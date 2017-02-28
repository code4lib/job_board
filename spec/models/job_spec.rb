require 'rails_helper'

RSpec.describe Job, type: :model do
  describe '#display_title' do
    it 'is the job title' do
      subject.update(title: 'Some title')
      expect(subject.display_title).to eq 'Some title'
    end
    
    it 'includes the employer information' do
      subject.update(title: 'Some title', employer_name: 'Foo Corp')
      
      expect(subject.display_title).to eq 'Some title at Foo Corp'
    end
  end

  describe '#employer_name=' do
    it 'creates a new employer' do
      expect { subject.employer_name = 'Foo Corp' }.to change(Employer, :count).by(1)
    end
    
    it 're-uses an existing employer of the same name' do
      employer = Employer.create(name: 'Foo Corp')
      
      subject.employer_name = 'Foo Corp'
      
      expect(subject.employer).to eq employer
    end
  end

  describe '#publish!' do
    it 'marks the job as published' do
      subject.publish!
      
      expect(subject).to be_published
      expect(subject.published_at).to be > 1.minute.ago
    end
  end
end
