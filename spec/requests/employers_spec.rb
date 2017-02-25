require 'rails_helper'

RSpec.describe "Employers", type: :request do
  describe "GET /employers" do
    it "works! (now write some real specs)" do
      get employers_path
      expect(response).to have_http_status(200)
    end
  end
end
