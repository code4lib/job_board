require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe JobsController, type: :controller do
  let(:user) { FactoryGirl.build(:admin) }
  before do
    allow(controller).to receive(:current_user).and_return(user)
  end

  # This should return the minimal set of attributes required to create a valid
  # Job. As you add validations to Job, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { title: 'xyz', description: 'xyz', url: 'http://', job_type: 'full_time', employer_name: 'foo corp' }
  }

  let(:invalid_attributes) {
    { title: '' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JobsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all jobs as @jobs" do
      job = Job.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:jobs)).to eq([job])
    end
  end

  describe "GET #show" do
    it "assigns the requested job as @job" do
      job = Job.create! valid_attributes
      get :show, params: {id: job.to_param}, session: valid_session
      expect(assigns(:job)).to eq(job)
    end
  end

  describe "GET #new" do
    it "assigns a new job as @job" do
      get :new, params: {}, session: valid_session
      expect(assigns(:job)).to be_a_new(Job)
    end
  end

  describe "GET #edit" do
    it "assigns the requested job as @job" do
      job = Job.create! valid_attributes
      get :edit, params: {id: job.to_param}, session: valid_session
      expect(assigns(:job)).to eq(job)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new published Job" do
        expect {
          post :create, params: {job: valid_attributes}, session: valid_session
        }.to change(Job.published, :count).by(1)
      end

      it "tracks the user that created the job" do
        post :create, params: {job: valid_attributes}, session: valid_session
        expect(assigns(:job).user).to eq user
      end

      it "assigns a newly created job as @job" do
        post :create, params: {job: valid_attributes}, session: valid_session
        expect(assigns(:job)).to be_a(Job)
        expect(assigns(:job)).to be_persisted
      end

      it "redirects to the created job" do
        post :create, params: {job: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Job.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved job as @job" do
        post :create, params: {job: invalid_attributes}, session: valid_session
        expect(assigns(:job)).to be_a_new(Job)
      end

      it "re-renders the 'new' template" do
        post :create, params: {job: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'abc' }
      }

      it "updates the requested job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: new_attributes}, session: valid_session
        job.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested job as @job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: valid_attributes}, session: valid_session
        expect(assigns(:job)).to eq(job)
      end

      it "redirects to the job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: valid_attributes}, session: valid_session
        expect(response).to redirect_to(job)
      end
    end

    context "with invalid params" do
      it "assigns the job as @job" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: invalid_attributes}, session: valid_session
        expect(assigns(:job)).to eq(job)
      end

      it "re-renders the 'edit' template" do
        job = Job.create! valid_attributes
        put :update, params: {id: job.to_param, job: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested job" do
      job = Job.create! valid_attributes
      expect {
        delete :destroy, params: {id: job.to_param}, session: valid_session
      }.to change(Job, :count).by(-1)
    end

    it "redirects to the jobs list" do
      job = Job.create! valid_attributes
      delete :destroy, params: {id: job.to_param}, session: valid_session
      expect(response).to redirect_to(jobs_url)
    end
  end

end
