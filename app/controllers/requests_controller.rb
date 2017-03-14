class RequestsController < ApplicationController

  before_action :authenticate_user!

  after_action :verify_policy_scoped, only: :index

  def index
    @requests = policy_scope(Request)
  end

  def create
    request = Request.new(request_params)
    request.student = current_user
    if request.save
      redirect_to user_path(request.teacher), notice: "Request sent"
    else
      redirect_to root_path, alert: "Can't make a request"
    end
  end

  # def update
  #   request = Request.find_by(id: params[:id])
  #   return redirect_to requests_path, alert: "Requst doesn't exist" if !request
  #   authorize request
  #
  #   case params[:request_action]
  #   when "confirm"
  #     request.update(status: "confirmed")
  #     redirect_to user_studyships_path()
  #   when "decline"
  #     request.update(status: "declined")
  #   end
  # end

  def destroy
    request = Request.find_by(id: params[:id])
    return redirect_to requests_path, alert: "Requst doesn't exist" if !request
    authorize request

    request.delete
    redirect_to requests_path, notice: "Request declined"
  end

  private

    def request_params
      params.require(:request).permit(:description, :teacher_id)
    end
end
