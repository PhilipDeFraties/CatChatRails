# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include JsonWebToken
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  private
  def authenticate_request
    header = request.headers["Authorization"]
    header = header.split(" ").last if header
    begin
      decoded = jwt_decode(header)
    rescue JWT::DecodeError
      raise ActiveRecord::RecordNotFound
    end
    @current_user = User.find_by_id(decoded[:user_id])
  end
end
