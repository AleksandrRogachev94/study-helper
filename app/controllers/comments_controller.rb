class CommentsController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized, except: [:show]

  before_action :set_comment, only: [:update, :destroy]

  def create
    @lesson = Lesson.find_by(id: params[:comment][:lesson_id])
    return redirect_to root_path, alert: "Lesson doesn't exist" if !@lesson

    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.lesson = @lesson
    authorize @comment

    respond_to do |f|
      if @comment.save
        f.html { redirect_to user_lesson_path(@lesson.author, @lesson), notice: "Successfully created comment" }
        f.json { render json: @comment, status: :created }
      else
        f.html { redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Can't create comment" }
        f.json { render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @comment
    lesson = @comment.lesson
    @comment.delete
    respond_to do |f|
      f.html { redirect_to user_lesson_path(lesson.author, lesson), notice: "Successfully deleted comment" }
      f.json { render json: @comment, status: :ok }
    end
  end

  def update
    authorize @comment
    lesson = @comment.lesson
    if @comment.update(params)
      redirect_to user_lesson_path(lesson.author, lesson), notice: "Successfully updated comment"
    else
      redirect_to user_lesson_path(lesson.author, lesson), alert: "Can't update comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_comment
      @comment = Comment.find_by(id: params[:id])
      redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Comment doesn't exist" if !@comment
    end
end
