class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
      return redirect_to root_path, alert: "The User doesn't exist" if !@user
    end
end
