#
class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    lesson = Lesson.find_by(id: params[:comment][:lesson_id])
    return redirect_to root_path, alert: "Lesson doesn't exist" if !lesson

    @comment.lesson = lesson
    if @comment.save
      redirect_to user_lesson_path(lesson.user, lesson)
    else
      redirect_to user_lesson_path(lesson.user, lesson), alert: "Can't create comment"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
end
