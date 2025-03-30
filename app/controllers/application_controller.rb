# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pundit::Authorization

  before_action :authenticate_user
  rescue_from Pundit::NotAuthorizedError, with: :forbidden

  private
    def authenticate_user
      @current_user = find_user_from_jwt
      return if @current_user

      render_unauthorized_error
    end

    def find_user_from_jwt
      token = extract_token_from_header
      return unless token

      decode_and_find_user(token)
    rescue JWT::DecodeError => e
      @auth_error = "Invalid token: #{e.message}"
      nil
    end

    def extract_token_from_header
      token = request.headers["Authorization"]&.split(" ")&.last
      unless token.present?
        @auth_error = "Token not found"
        return nil
      end

      token
    end

    def decode_and_find_user(token)
      jwt_payload = JWT.decode(token, Rails.application.credentials.fetch(:secret_key_base)).first
      User.find_by(id: jwt_payload["sub"])
    end

    def render_unauthorized_error
      render json: {
        status: 401,
        message: @auth_error || "Unauthorized access"
      }, status: :unauthorized
    end

    def forbidden
      render json: { errors: ["Access denied."] }, status: :forbidden
    end
end
