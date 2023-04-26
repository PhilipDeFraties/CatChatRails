require 'rails_helper'

RSpec.describe Api::V1::AuthenticationController, type: :controller do
  let(:user) { create(:user) }

  describe 'POST #login' do
    context 'with valid credentials' do
      it 'returns a valid token' do
        post :login, params: { username: user.username, password: user.password }

        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['user']).to eq(user.username)
        expect(json_response['accessToken']).not_to be_nil
        expect(json_response['roles']).to include(user.role)
      end
    end

    context 'with invalid credentials' do
      it 'returns unauthorized status' do
        post :login, params: { username: user.username, password: 'wrong_password' }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('unauthorized')
      end
    end

    context 'with missing credentials' do
      it 'returns unauthorized status' do
        post :login, params: { username: nil, password: nil }

        expect(response).to have_http_status(:unauthorized)
        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('unauthorized')
      end
    end
  end
end