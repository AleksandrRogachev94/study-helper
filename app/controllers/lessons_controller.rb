class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]
  prepend_before_action :set_user

  after_action :verify_authorized

  def index
    stub_lesson = Lesson.new(user: @user) # Stub for authorization if LessonPolicy.
    authorize stub_lesson
    @lessons_by_categories = @user.lessons_by_categories
  end

  def show
    authorize @lesson
  end

  def new
    @lesson = Lesson.new(user: @user)
    authorize @lesson
  end

  private

    def set_user
      @user = User.find_by(id: params[:user_id])
      return redirect_to root_path, alert: "The User doesn't exist" if !@user
    end

    def set_lesson
      @lesson = @user.lessons.find_by(id: params[:id])
      return redirect_to root_path, alert: "The Lesson doesn't exist or belong to this author" if !@lesson
    end
end
