require 'rails_helper'

describe ModerateController do
  let(:user) { FactoryGirl.build(:admin) }
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  let!(:job) do
    FactoryGirl.create(:job, tag_list: 'x', published: true)
  end
  
  let!(:unpublished_job) do
    FactoryGirl.create(:job, tag_list: 'x', published: false)
  end

  describe '#index' do
    it 'assigns all unpublished jobs as @jobs' do
      get :index, params: {}, session: valid_session
      expect(assigns(:jobs)).to include unpublished_job
      expect(assigns(:jobs)).not_to include job
    end
  end

  describe '#publish' do
    it 'publishes the given job' do
      get :publish, params: { id: job.id }, session: valid_session
      expect(assigns(:job)).to eq job
      
      job.reload
      
      expect(job).to be_published
    end
  end
end
