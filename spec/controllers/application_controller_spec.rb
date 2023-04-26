require 'rails_helper'

class ApplicationController < ActionController::Base
  def test_action
    head :ok
  end
end

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:token) { controller.jwt_encode(user_id: user.id) }

  before do
    Rails.application.routes.draw do
      get 'test_action' => 'application#test_action'
    end
  end

  after do
    Rails.application.reload_routes!
  end

  describe 'authenticate_request' do
    context 'with valid token' do
      it 'sets the current_user' do
        request.headers['Authorization'] = "Bearer #{token}"
        get :test_action

        expect(assigns(:current_user)).to eq(user)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid token' do
      it 'returns an error' do
        request.headers['Authorization'] = 'Bearer invalid_token'
        
        expect { get :test_action }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'with no token' do
      it 'returns an error' do
        expect { get :test_action }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end