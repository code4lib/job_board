require 'rails_helper'

describe Users::OmniauthCallbacksController do
  let(:mock_user) { FactoryBot.create(:user) }

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe '#authorize' do
    it 'works' do
      allow(User).to receive(:find_or_create_by).with(provider: 'mock', uid: 'uid').and_return(mock_user)

      @request.env['omniauth.auth'] = double(provider: 'mock', uid: 'uid')

      get :code4lib

      expect(response).to redirect_to root_url
      expect(controller.current_user).to eq mock_user
    end
  end
end
