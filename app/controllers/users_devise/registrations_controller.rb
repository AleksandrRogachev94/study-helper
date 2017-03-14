class UsersDevise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |user_params|
        user_params.permit(:password, :password_confirmation, :email,
          profile_attributes: [:first_name, :last_name, :phone_number, :age, :interests, :degree, :study_place])
      end
    end
end
