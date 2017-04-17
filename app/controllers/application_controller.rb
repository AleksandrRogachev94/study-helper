class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

    def user_not_authorized
      msg = "You are not authorized to perform this action."
      respond_to do |f|
        f.html { flash[:alert] = msg; return redirect_to(request.referrer || root_path) }
        f.json { render json: { errors: [msg] }, status: :unauthorized }
      end
    end
end
