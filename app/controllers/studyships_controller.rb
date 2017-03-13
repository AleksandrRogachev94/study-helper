class StudyshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:create]
  before_action :set_user, only: [:teachers, :students]

  def create
    #Check if ship is already includeed!!!!
    if Studyship.establish_mutual_relationships(teacher: @teacher, student: current_user)
      redirect_to user_teachers_path(current_user), notice: "Successfully added new Teacher"
    else
      redirect_to (:back), alert: "Can't establish relationship"
    end
  end

  def destroy
  end

  def teachers
    @teachers = @user.teachers
  end

  def students
    @students = @user.students
  end

  private

    def set_teacher
      @teacher = User.find_by(id: params[:teacher_id])
      if !@teacher || @teacher == current_user
        flash[:alert] = "User doesn't exist"
        return redirect_to(:back)
      end
    end

    def set_user
      @user = User.find_by(id: params[:user_id])
      return redirect_to root_path, alert: "User doesn't exist" if !@user
    end
end
