# app/controllers/api/v1/users/sessions_controller.rb
module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil) # Genera el token JWT
          render json: { message: "Logged in successfully.", user: resource, token: token[0] }, status: :ok
        end

        def respond_to_on_destroy
          head :no_content
        end
      end
    end
  end
end
