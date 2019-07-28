require 'rss'

class JsonApiParser
  attr_reader :url

  def self.harvest!(url)
    new(url).harvest!
  end

  def initialize(url)
    @url = url
  end

  def harvest!
    items.each do |item|
      Job.with_deleted.find_or_initialize_by(source_id: item['links']['self']) do |job|
        job.assign_attributes(item['attributes'].merge(description_markup: '.html'))
        employer_name = item.dig('relationships', 'employer', 'data', 'name')
        job.employer = Employer.find_or_initialize_by(name: employer_name) if employer_name
        job.save
      end
    end
  end

  private

  def items
    data.dig('data') || []
  end

  def data
    @data ||= JSON.parse(response)
  end

  def response
    Faraday.get(url).body
  end
end
