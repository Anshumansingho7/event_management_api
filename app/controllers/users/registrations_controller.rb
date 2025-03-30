# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    before_action :configure_permitted_parameters, only: [:create]
    skip_before_action :authenticate_user, only: [:create]

    private
      def respond_with(resource, _options = {})
        if resource.persisted?
          render json: {
            status: { code: 200, message: "Signed up successfully" },
            data: resource
          }
        else
          render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def configure_permitted_parameters
        permitted_role = params.dig(:user, :role)

        unless User.roles.keys.include?(permitted_role)
          render json: { errors: ["Role is invalid"] }, status: :unprocessable_entity
          return
        end

        devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role])
      end
  end
end
