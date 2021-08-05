require 'rails_helper'

RSpec.describe "AuthenticationControllers", type: :request do
  describe '#login' do 
    context "valid login" do
      let!(:user)            { create :user }
      let(:valid_data)      { {user: {username: 'admin', password: 'admin'} } }
      let(:invalid_data)      { {user: {username: 'fail', password: 'fail'} } }

      it "success" do 
        post auth_login_path, params: valid_data
        r = JSON.parse(response.body)

        expect(response.success?).to eq true
        expect(r['token'].present?).to eq true
      end

      it "fails" do
        post auth_login_path, params: invalid_data

        expect(response.success?).to eq true
        expect(response.body).to eq 'null'
      end
    end
  end
end
