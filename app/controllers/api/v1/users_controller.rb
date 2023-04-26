class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show]

  def index
    users = User.all

    if users.present?
      render json: users, status: :ok
    else
      render json: { errors: ['no users found'] }, status: :not_found
    end
  end

  def show
    if @user
      render json: @user, status: :ok
    else
      render json: { errors: ['user not found'] }, status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = jwt_encode(user_id: @user.id)
      render json: { user: @user, accessToken: token }, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['user not found'] }, status: :not_found
  end
end
