require 'rails_helper'

describe FeedParser do
  subject(:feed) { described_class.new(url) }
  let(:url) { 'http://example.com/jobs.rss' }
  let(:response_body) do <<-EOF
<?xml version="1.0" encoding="UTF-8"?><rss version="2.0"
	xmlns:content="http://purl.org/rss/1.0/modules/content/"
	xmlns:wfw="http://wellformedweb.org/CommentAPI/"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:sy="http://purl.org/rss/1.0/modules/syndication/"
	xmlns:slash="http://purl.org/rss/1.0/modules/slash/">

<channel>
	<title>Digital Library Jobs &#8211; DigitalKoans</title>
	<link>http://digital-scholarship.org/digitalkoans</link>
	<description>What Is the Sound of One E-Print Downloading?</description>
	<item>
    <title>Head, Open Scholarship Services at Queen&#8217;s University</title>
  		<link>http://digital-scholarship.org/digitalkoans/2017/02/27/head-open-scholarship-services-at-queens-university/</link>
  		<pubDate>Mon, 27 Feb 2017 13:33:46 +0000</pubDate>
  		<dc:creator><![CDATA[Charles W. Bailey, Jr.]]></dc:creator>
  				<category><![CDATA[Digital Library Jobs]]></category>

  		<guid isPermaLink="false">http://digital-scholarship.org/digitalkoans/?p=31179</guid>
  		<description><![CDATA[Queen&#39;s University is recruiting a Head, Open Scholarship Services. Here&#39;s an excerpt from the ad: Reporting to an Associate University Librarian and working with colleagues across the library and the university, the Head leads the division in developing a culture and services that encourage the sharing, as openly as possible, and preservation of Queen&#8217;s scholarly [&#8230;]]]></description>
		</item>
  </channel>
  EOF
  end

  before do
    allow(Faraday).to receive(:get).and_return(double(body: response_body))
  end

  describe '#harvest!' do
    it 'creates new jobs from the rss feed' do
      expect { subject.harvest! }.to change(Job, :count).by(1)
    end
    
    it 'does not duplicate results' do
      subject.harvest!
      expect { subject.harvest! }.to change(Job, :count).by(0)
    end
    
    it 'does not duplicate deleted results' do
      subject.harvest!
      Job.last.destroy
      expect { subject.harvest! }.to change(Job, :count).by(0)
    end

    it 'populates job metadata' do
      subject.harvest!

      job = Job.last
      expect(job.title).to start_with 'Head, Open Scholarship'
      expect(job.description).to start_with "Queen&#39;s University is"
      expect(job.origin).to eq url
      expect(job.source_id).to eq 'http://digital-scholarship.org/digitalkoans/?p=31179'
      expect(job.url).to eq 'http://digital-scholarship.org/digitalkoans/2017/02/27/head-open-scholarship-services-at-queens-university/'
    end
  end
end
