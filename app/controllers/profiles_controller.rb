class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]

  def edit
  end

  def update
  end

  private

    def set_profile
      @user = User.find_by(id: params[:user_id])
      @profile = @user.try(:profile)
      return redirect_to root_path, alert: "User doesn't exit" if !@profile
    end
end
