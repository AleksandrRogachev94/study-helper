module UsersHelper
  def link_for_user_lessons(lesson)
    if policy(lesson).index?
      link_to "Lessons", user_lessons_path(lesson.user)
    elsif Request.find_by(student: current_user, teacher: lesson.user)
      content_tag 'div', "Request sent", class: "request_sent"
    else
      render 'requests/form'
    end
  end
end
