class RequestsController < ApplicationController

  before_action :authenticate_user!

  def index
  end

  def create
    # teacher = User.find_by(id: params[:teacher_id])
    #
    # if teacher.nil? || current_user.teachers.include?(teacher)
    #   flash[:alert] = "User doesn't exist or you already have him as teacher"
    #   return redirect_to(:back)
    # end

    request = Request.new(request_params)
    request.student = current_user
    if request.save
      redirect_to user_path(request.teacher), notice: "Request sent"
    else
      redirect_to root_path, alert: "Can't make a request"
    end
  end

  private

    def request_params
      params.require(:request).permit(:description, :teacher_id)
    end
end
