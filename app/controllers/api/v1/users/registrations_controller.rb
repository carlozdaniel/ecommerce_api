module Api
  module V1
    module Users
      class RegistrationsController < Devise::RegistrationsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          if resource.persisted?
            render json: { message: "User created successfully." }, status: :created
          else
            render json: { error: resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        def sign_up(resource_name, resource)
          # Omite el inicio de sesión automático
        end
      end
    end
  end
end
