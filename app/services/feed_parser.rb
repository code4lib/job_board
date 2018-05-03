require 'rss'

class FeedParser
  attr_reader :url

  def self.harvest!
    Settings.feeds.each do |feed|
      new(feed).harvest!
    end
  end

  def initialize(url)
    @url = url
  end

  def harvest!
    items.each do |item|
      Job.with_deleted.find_or_initialize_by(source_id: item.guid&.content || item.link) do |job|
        job.assign_attributes(
          title: item.title,
          description: item.description,
          description_markup: '.html',
          origin: url,
          url: item.link,
          created_at: item.date,
          job_type: :uncategorized
        )
        job.save
      end
    end
  end

  private

  def items
    feed.items
  end

  def feed
    @feed ||= RSS::Parser.parse(response)
  end

  def response
    Faraday.get(url).body
  end
end
