class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_lesson

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.lesson = @lesson

    if @comment.save
      redirect_to user_lesson_path(@lesson.author, @lesson)
    else
      redirect_to user_lesson_path(@lesson.author, @lesson), alert: "Can't create comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def set_lesson
      @lesson = Lesson.find_by(id: params[:comment][:lesson_id])
      return redirect_to root_path, alert: "Lesson doesn't exist" if !@lesson
    end
end
