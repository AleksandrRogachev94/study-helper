class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update, :show]

  after_action :verify_authorized

  def show
    authorize @profile
    render json: @profile, status: :ok
  end

  def edit
    authorize @profile
  end

  def update
    authorize @profile

    respond_to do |f|
      if @profile.update(profile_params)
        f.html { redirect_to user_path(current_user), notice: "Successfully updated profile" }
        f.json { render json: @profile, status: :ok }
      else
        f.html { render 'edit' }
        f.json { render json: { errors: @profile.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_profile
      @profile = current_user.try(:profile)
    end

    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :age, :degree, :interests, :study_place, :avatar)
    end
end
