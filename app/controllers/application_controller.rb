class ApplicationController < ActionController::API
  private

  def authenticate_user_or_doorkeeper!
    if doorkeeper_token
      doorkeeper_authorize!
    else
      authenticate_user!
    end
  end
end
