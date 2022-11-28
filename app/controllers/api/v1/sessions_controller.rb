class Api::V1::SessionsController < ApplicationController
  def create
    binding.pry
  end

  private

  def login_params
    params.require(:session).permit(:username, :password)
  end
end
