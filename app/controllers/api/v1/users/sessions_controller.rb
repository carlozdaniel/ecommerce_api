module Api
  module V1
    module Users
      class SessionsController < Devise::SessionsController
        respond_to :json

        private

        def respond_with(resource, _opts = {})
          render json: { message: "Logged in successfully.", user: current_user }, status: :ok
        end

        def respond_to_on_destroy
          jwt_payload = JWT.decode(request.headers["Authorization"].split(" ").last,
                                   Rails.application.credentials.dig(:devise, :jwt_secret_key)).first
          current_user = User.find(jwt_payload["sub"])
          if current_user
            render json: { message: "Logged out successfully." }, status: :ok
          else
            render json: { message: "User has no active session." }, status: :unauthorized
          end
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          render json: { error: "Invalid token or user not found." }, status: :unauthorized
        end
      end
    end
  end
end
