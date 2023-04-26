class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  # POST api/v1/auth/login
  def login
    user = User.find_by_username(params[:username])
    if user&.authenticate(params[:password])
      token = jwt_encode(user_id: user.id)
      render json: { user: user.username, accessToken: token, roles: [user.role] }, status: :ok
    else
      render json: {error: 'unauthorized' }, status: :unauthorized
    end
  end
end
