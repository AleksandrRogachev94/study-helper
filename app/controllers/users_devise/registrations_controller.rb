class UsersDevise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  def new
    super do
      @profile = Profile.new
    end
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:password, :password_confirmation, :email, profile_attributes: [:first_name])
      end
    end
end
