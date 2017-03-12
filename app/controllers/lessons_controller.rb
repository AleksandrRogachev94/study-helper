class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:index]

  def index
    @lessons_by_categories = @user.lessons_by_categories
  end

  def show
  end

  private

    def set_user
      @user = User.find_by(id: params[:user_id])
      return redirect_to root_path, alert: "The User doesn't exist" if !@user
    end

    def set_lesson
      set_user
      @lesson = @user.lessons.find_by(id: params[:id])
      return redirect_to root_path, alert: "The Lesson doesn't exist" if !@lesson
    end
end
