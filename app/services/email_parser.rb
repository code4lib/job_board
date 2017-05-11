class Object
  def to_imap_date
    date = respond_to?(:utc) ? utc.to_s : to_s
    Date.parse(date).strftime("%d-%b-%Y")
  end  
end

class EmailParser
  class << self
    def harvest!
      return unless Settings.email.user

      Gmail.connect!(Settings.email.user, Settings.email.password) do |gmail|
        gmail.inbox.emails(:unread, after: Date.parse('2017-03-01')).each do |message|
          Rails.logger.debug "[#{message.message_id}] Loaded message  #{message.subject}"
          email = EmailParser.new(message)
          if email.job? && email.valid?
            job = email.adapt_to_job
            job.save! unless job.persisted?
          end

          message.read!
        end
      end
    end
  end
  
  attr_reader :email
  delegate :message, to: :email
  delegate :subject, :message_id, :from, :body, :date, to: :message

  def initialize(email)
    @email = email
  end
  
  def adapt_to_job
    Job.with_deleted.find_or_initialize_by(source_id: message_id, origin: 'email') do |job|
      job.title = sanitized_subject
      job.description = description
      job.description_markup = description_markup
      job.contact = Array(from).first
      job.created_at = date
      job.job_type = :uncategorized

      Rails.logger.info "[#{message_id}] Converted to #{job.inspect}"
    end
  end
  
  def description
    if message.html_part && message.html_part.present?
      message.html_part.decoded
    else
      (message.text_part || message).decoded
    end
  end
  
  def description_markup
    if message.html_part.present?
      '.html'
    else
      '.txt'
    end
  end
  
  def sanitized_subject
    subject.sub('[CODE4LIB]', '').sub(/[\n\r]/, '').sub(/\s+/, ' ').sub(/^(job|position|employment|vacancy):\s*/i, '')
  end
  
  def valid?
    return false if description.match?('jobs.code4lib.org')
    
    true
  end
  
  def job?
    return false unless subject.present?
    return false if subject =~ /^re:/i

    subject =~ /(job|position|employment|vacancy)/i
  end
end
