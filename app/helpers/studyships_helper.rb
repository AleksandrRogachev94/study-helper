module StudyshipsHelper
  def list_index_students(user)
    if user == current_user
      "Your students"
    else
      "Students of #{user.email}"
    end
  end

  def list_index_teachers(user)
    if user == current_user
      "Your teachers"
    else
      "Teachers of #{user.email}"
    end
  end
end
