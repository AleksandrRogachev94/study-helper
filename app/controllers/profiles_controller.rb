class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update]

  def edit
  end

  def update
    authorize @profile
    if @profile.update(profile_params)
      redirect_to user_path(current_user), notice: "Successfully updated profile"
    else
      render 'edit'
    end
  end

  private

    def set_profile
      @profile = current_user.try(:profile)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :age, :degree, :interests, :study_place, :image)
    end
end
