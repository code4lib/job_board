class JobsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :show

  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = @jobs.where(job_type: params[:job_type]) if params[:job_type]
    @jobs = @jobs.page(params[:page])

    respond_to do |format|
      format.html
      format.json
      format.atom
    end
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job.description_markup ||= '.html'
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    respond_to do |format|
      if verify_recaptcha(model: @job) && @job.save
        format.html { redirect_to @job, notice: 'Thanks for your submission; a moderator will approve and publish your question soon.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :url, :description, :user, :job_type, :telecommute, :employer_name, :location, :contact, :tag_list)
    end

    def create_params
      job_params.merge(
        user: current_user,
        published: current_user.present? && current_user.autopublish?,
        published_at: Time.now,
        origin: request.original_url
      )
    end
end
