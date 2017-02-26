class HomeController < ApplicationController
  def index
    @jobs = Job.accessible_by(current_ability).page(1).per(5)
  end
end
