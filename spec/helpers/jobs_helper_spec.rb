require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the JobsHelper. For example:
#
# describe JobsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe JobsHelper, type: :helper do
  let(:job) { FactoryGirl.create(:job) }

  describe '#render_job_badge' do
    it 'renders a full time badge' do
      job.job_type = :full_time
      expect(helper.render_job_badge(job)).to have_selector 'a.badge.badge-success'
    end

    it 'renders a part time badge' do
      job.job_type = :part_time
      expect(helper.render_job_badge(job)).to have_selector 'a.badge.badge-info'
    end

    it 'renders a internship badge' do
      job.job_type = :internship
      expect(helper.render_job_badge(job)).to have_selector 'a.badge.badge-danger'
    end

    it 'renders a part time badge' do
      job.job_type = :temporary
      expect(helper.render_job_badge(job)).to have_selector 'a.badge.badge-warning'
    end

    it 'renders an uncategorized badge' do
      job.job_type = :uncategorized
      expect(helper.render_job_badge(job)).to have_selector 'a.badge.badge-default'
    end
  end
end
