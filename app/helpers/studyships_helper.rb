module StudyshipsHelper
  def header_index_students(user)
    if user == current_user
      "Your students"
    else
      "Students of #{user.email}"
    end
  end

  def header_index_teachers(user)
    if user == current_user
      "Your teachers"
    else
      "Teachers of #{user.email}"
    end
  end
end
