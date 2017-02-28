require 'rails_helper'

describe TagsController do
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe '#index' do
    before do
      FactoryGirl.create(:job, tag_list: 'a, b, c', published: true)
      FactoryGirl.create(:job, tag_list: 'not_published', published: false)
    end

    it 'assigns all published tags as @tags' do
      get :index, params: {}, session: valid_session
      expect(assigns(:tags).map(&:name)).to include 'a', 'b', 'c'
      expect(assigns(:tags).map(&:name)).not_to include 'not_published'
    end
  end

  describe '#show' do
    let!(:job) do
      FactoryGirl.create(:job, tag_list: 'x', published: true)
    end
    
    let!(:unpublished_job) do
      FactoryGirl.create(:job, tag_list: 'x', published: false)
    end

    it 'assigns the tag as @tag' do
      get :show, params: { id: 'x' }, session: valid_session
      expect(assigns(:tag)).to eq 'x'
    end

    it 'assigns jobs with that tag as @jobs' do
      get :show, params: { id: 'x' }, session: valid_session
      expect(assigns(:jobs)).to eq([job])
    end
  end
end
