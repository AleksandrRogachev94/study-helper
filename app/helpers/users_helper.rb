module UsersHelper
  def link_for_user_lessons(lesson)
    if policy(lesson).index?
      link_to "Lessons", user_lessons_path(lesson.user)
    else
      link_to "Add as a Teacher", user_studyships_path(lesson.user, "students"), method: 'post'
    end
  end
end
