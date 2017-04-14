module UsersHelper
  def link_for_user_lessons(lesson)
    if policy(lesson).index?
      link_to "Lessons", user_lessons_path(lesson.author), class: "btn btn-primary"
    elsif Request.find_by(student: current_user, teacher: lesson.author)
      content_tag 'div', "Request sent", class: "request_sent"
    else
      render 'requests/form'
    end
  end

  def user_class_bs(user)
    result = "list-group-item list-group-item-action"

    if current_user.students.include?(user) && current_user.teachers.include?(user)
      result << " list-group-item-success"
    elsif current_user.students.include?(user) #your student
      result << " list-group-item-purple"
    elsif current_user.teachers.include?(user) #your teacher
      result << " list-group-item-info"
    end
    result
  end
end
