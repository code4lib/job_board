class ModerateController < ApplicationController
  load_and_authorize_resource :job, parent: false

  def index
    authorize! :moderate, Job
    @jobs = @jobs.unscoped.accessible_by(current_ability).unpublished.order(created_at: :asc)
    @jobs = @jobs.page(params[:page]).per(100)
  end

  def publish
    @job.publish!

    respond_to do |format|
      format.html { redirect_back(moderate_jobs_path) }
      format.js { head :ok }
    end
  end
end
