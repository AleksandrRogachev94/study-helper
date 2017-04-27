class LessonsController < ApplicationController

  before_action :authenticate_user!

  prepend_before_action :set_user
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  after_action :verify_authorized

  def index
    @stub_lesson = Lesson.new(author: @user) # Stub for authorization in LessonPolicy.
    authorize @stub_lesson
    @lessons_by_categories = @user.lessons_by_categories
    respond_to do |f|
      f.html
      f.json { render json: @lessons_by_categories, root: true, status: :ok }
    end
  end

  def show
    authorize @lesson

    respond_to do |f|
      f.html
      f.json { render json: @lesson, status: :ok }
    end
  end

  def new
    @lesson = Lesson.new(author: @user)
    @lesson.build_category
    authorize @lesson
  end

  def create
    @lesson = Lesson.new(lesson_params)
    @lesson.author = @user
    authorize @lesson
    if @lesson.save
      redirect_to user_lesson_path(@user, @lesson), notice: "Successfully created lesson"
    else
      render 'new'
    end
  end

  def edit
    authorize @lesson
  end

  def update
    authorize @lesson
    if @lesson.update(lesson_params)
      redirect_to user_lesson_path(@user, @lesson), notice: "Successfully updated lesson"
    else
      render 'edit'
    end
  end

  def destroy
    authorize @lesson
    @lesson.delete
    redirect_to user_lessons_path(@user)
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

    def lesson_params
      params.require(:lesson).permit(:title, :doc1, :doc2, :doc3, :description, :content, :links, :category_id, :category_attributes => [:title])
    end
end
