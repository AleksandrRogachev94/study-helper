class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.search(params[:search])
  end

  def show
    @stub_lesson = @user.lessons.build
  end

  private

    def set_user
      @user = User.find_by(id: params[:id])
      return redirect_to root_path, alert: "User doesn't exist" if !@user
    end
end
