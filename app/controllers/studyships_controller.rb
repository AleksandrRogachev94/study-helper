class StudyshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_teacher, only: [:create]
  before_action :set_user, only: [:index]

  after_action :verify_authorized, only: [:create, :index]

  def create
    authorize Studyship

    if Studyship.establish_mutual_relationships(teacher: @teacher, student: current_user)
      redirect_to user_studyships_path(current_user, "teachers"), notice: "Successfully added new Teacher"
    else
      redirect_to (:back), alert: "Can't establish relationship"
    end
  end

  def destroy
  end

  # Stub is needed to authorize action
  def index
    case params[:rel_type]
    when "students"
      studyship_stub = @user.teacher_student_relationships.build
      @users = @user.students
    when "teachers"
      studyship_stub = @user.student_teacher_relationships.build
      @users = @user.teachers
    else
      return redirect_to(:back), alert: "Relationships must be '/students' or '/teachers'"
    end

    authorize studyship_stub
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
