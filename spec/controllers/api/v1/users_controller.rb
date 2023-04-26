require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { controller.jwt_encode(user_id: user.id) }

  before do
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    context 'when there are users' do
      let!(:users) { create_list(:user, 3) }

      it 'returns a list of users' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(4) # including the initially created user
      end
    end

    context 'when there are no users' do
      it 'returns an error' do
        User.delete_all
        get :index
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["errors"]).to include('no users found')
      end
    end
  end

  describe 'GET #show' do
    context 'when the user is found' do
      it 'returns the user' do
        get :show, params: { id: user.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["id"]).to eq(user.id)
      end
    end

    context 'when the user is not found' do
      it 'returns an error' do
        get :show, params: { id: -1 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["errors"]).to include('user not found')
      end
    end
  end

  describe 'POST #create' do
    context 'when valid parameters are provided' do
      let(:user_attributes) { attributes_for(:user) }

      it 'creates a new user' do
        expect {
          post :create, params: { user: user_attributes }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when invalid parameters are provided' do
      let(:invalid_attributes) { { username: '', password: '' } }

      it 'does not create a new user' do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end