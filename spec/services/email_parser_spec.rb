require 'rails_helper'

describe EmailParser do
  subject(:parser) { described_class.new(email) }
  let(:email) { double('Email', message: message) }
  let(:message) do
    double(
      'Message',
      message_id: '',
      date: Time.zone.parse('2017-05-22T01:02:03Z'),
      subject: 'x',
      from: 'poster@example.com',
      html_part: double(decoded: 'body')
    )
  end

  describe '#adapt_to_job' do
    subject(:job) { parser.adapt_to_job }

    it 'has a title' do
      expect(job.title).to eq 'x'
    end
    
    it 'has a description' do
      expect(job.description).to eq 'body'
      expect(job.description_markup).to eq '.html'
    end
    
    it 'has a contact' do
      expect(job.contact).to eq 'poster@example.com'
    end
    
    it 'has a created date' do
      expect(job.created_at).to eq Time.zone.parse('2017-05-22T01:02:03Z') 
    end
    
    it 'is initially uncategorized' do
      expect(job.job_type).to eq 'uncategorized'
    end
    
    context 'for a message with a text-only body' do
      before do
        allow(message).to receive_messages(html_part: nil, text_part: double(decoded: 'body'))
      end
      
      it 'has a description' do
        expect(job.description).to eq 'body'
        expect(job.description_markup).to eq '.txt'
      end
    end
    
    context 'for a message with tags and what-not in the subject' do
      before do
        allow(message).to receive(:subject).and_return('[CODE4LIB] Job: x ')
      end

      it 'strips the cruft' do
        expect(job.title).to eq 'x'
      end
    end
  end
  
  describe '#valid?' do
    context 'an email probably already posted' do
      before do
        allow(message).to receive(:html_part).and_return(double(decoded: 'https://jobs.code4lib.org/jobs/123'))
      end
      
      it { is_expected.not_to be_valid }
    end
    
    
    it { is_expected.to be_valid }
  end
  
  describe '#job?' do
    context 'for a reply to a message' do
      before do
        allow(message).to receive(:subject).and_return('RE: Your job posting')
      end

      it 'is not a postable job' do
        expect(subject).not_to be_a_job
      end
    end
    
    it 'is probably a job if certain keywords appear in the subject' do
      allow(message).to receive(:subject).and_return('Job: a new position')
      expect(subject).to be_a_job
    end
  end
end
