module LessonsHelper
  def list_index_title(user)
    if user == current_user
      "Your Lessons"
    else
      "Lessons of #{user.email}"
    end

  end
end
