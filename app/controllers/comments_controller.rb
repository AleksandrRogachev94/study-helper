class CommentsController < ApplicationController

  before_action :authenticate_user!
  after_action :verify_authorized

  before_action :set_lesson_from_hidden, only: [:update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def create
    @lesson = Lesson.find_by(id: params[:comment][:lesson_id])
    return redirect_to root_path, alert: "Lesson doesn't exist" if !@lesson

    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.lesson = @lesson
    authorize @comment

    if @comment.save
      redirect_to user_lesson_path(@lesson.author, @lesson), notice: "Successfully created comment"
    else
      redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Can't create comment"
    end
  end

  def destroy
    authorize @comment
    @comment.delete
    redirect_to user_lesson_path(@lesson.author, @lesson), notice: "Successfully deleted comment"
  end

  def update
    authorize @comment
    if @comment.update(params)
      redirect_to user_lesson_path(@lesson.author, @lesson), notice: "Successfully updated comment"
    else
      redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Can't update comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_lesson_from_hidden
      @lesson = Lesson.find_by(id: params[:lesson_id])
      return redirect_to root_path, alert: "Lesson doesn't exist" if !@lesson
    end

    def set_comment
      @comment = Comment.find_by(id: params[:id])
      redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Comment doesn't exist" if !@comment
    end
end
