require 'rails_helper'

describe User do
  describe '.from_omniauth' do
    let(:fake_auth) { double(provider: 'test', uid: 'xyz', info: double(email: 'test@example.com', nickname: 'test'))}

    it 'creates a user from oauth attributes' do
      expect { described_class.from_omniauth(fake_auth) }.to change(User, :count).by(1)
      
      user = User.find_by(provider: 'test', uid: 'xyz')
      expect(user.email).to eq 'test@example.com'
      expect(user.nickname).to eq 'test'
    end
  end
end
