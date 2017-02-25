class TagsController < ApplicationController
  def index
    @tags = Job.accessible_by(current_ability).tag_counts_on(:tags).order(taggings_count: :desc)
  end
  
  def show
    @tag = params[:id]
    @jobs = Job.accessible_by(current_ability).tagged_with(params[:id]).page(params[:page])
  end
end
