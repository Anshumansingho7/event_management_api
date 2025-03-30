# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :authenticate_user, only: [:create]

    def create
      user = User.find_for_database_authentication(email: params[:user][:email])
      if user&.valid_password?(params[:user][:password])
        sign_in(user)
        render json: {
          status: { code: 200, message: "User signed in successfully", data: user }
        }, status: :ok
      else
        render json: {
          status: { code: 422, errors: "Invalid email or password" }
        }, status: :unauthorized
      end
    end

    private
      def respond_with(_resource, _options = {})
        render json: {
          status: { code: 200, message: "User signed in successfully", data: current_user }
        }, status: :ok
      end
  end
end
