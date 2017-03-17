class Object
  def to_imap_date
    date = respond_to?(:utc) ? utc.to_s : to_s
    Date.parse(date).strftime("%d-%b-%Y")
  end  
end

class DigestParser
  class << self
    def harvest!
      return unless Settings.email.user

      Gmail.connect!(Settings.email.user, Settings.email.password) do |gmail|
        gmail.inbox.emails(:unread, after: Date.parse('2017-03-16')).each do |message|
          Rails.logger.debug "[#{message.message_id}] Loaded message  #{message.subject}"

          email = DigestParser.new(message)
          email.harvest! if email.digest?

          message.read!
        end
      end
    end
  end
  
  attr_reader :email

  def initialize(email)
    @email = email
  end
  
  def digest?
    email.message.subject =~ /^File: "CODE4LIB LOG/
  end
  
  def harvest!
    email.message.body.decoded.split('=========================================================================').each do |msg|
      m = EmailParser.new(Struct.new(:message).new(Mail.new(msg)))
      Rails.logger.debug "[#{m.message_id}] Loaded message  #{m.subject}"
      if m.job? && m.valid?
        job = m.adapt_to_job
        job.save! unless job.persisted?
      end
    end
  end
end
