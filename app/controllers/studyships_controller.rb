class StudyshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:create]
  before_action :set_user, only: [:teachers, :students]

  after_action :verify_authorized, only: [:create, :teachers, :students]

  def create
    authorize Studyship

    if Studyship.establish_mutual_relationships(teacher: @teacher, student: current_user)
      redirect_to user_teachers_path(current_user), notice: "Successfully added new Teacher"
    else
      redirect_to (:back), alert: "Can't establish relationship"
    end
  end

  def destroy
  end

  def teachers
    studyship_stub = @user.student_teacher_relationships.build
    authorize studyship_stub
    @teachers = @user.teachers
  end

  def students
    studyship_stub = @user.teacher_student_relationships.build
    authorize studyship_stub
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
