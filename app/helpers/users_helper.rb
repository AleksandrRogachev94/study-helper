module UsersHelper
  def link_for_user_lessons(lesson)
    if policy(lesson).index?
      link_to "Lessons", user_lessons_path(lesson.author), class: "yellow-button", id: "user-lessons-link"
    elsif Request.find_by(student: current_user, teacher: lesson.author)
      content_tag 'div', "Request sent", class: "request_sent"
    else
      render 'requests/form'
    end
  end

  def link_to_user(user)
    css_class = "list-group-item list-group-item-action"
    appearance = user.appearance

    if current_user.students.include?(user) && current_user.teachers.include?(user)
      css_class << " list-group-item-success"
      appearance << " (your student and teacher)"
    elsif current_user.students.include?(user) #your student
      css_class << " list-group-item-purple"
      appearance << " (your student)"
    elsif current_user.teachers.include?(user) #your teacher
      css_class << " list-group-item-info"
      appearance << " (your teacher)"
    end

    link_to appearance, user_path(user), class: css_class
  end

  def link_to_user_popular(user)
    css_class = "list-group-item list-group-item-action"
    appearance = user.appearance +  " - " + pluralize(user.students_count, "student")

    if current_user.students.include?(user) && current_user.teachers.include?(user)
      css_class << " list-group-item-success"
      appearance << " (your student and teacher)"
    elsif current_user.students.include?(user) #your student
      css_class << " list-group-item-purple"
      appearance << " (your student)"
    elsif current_user.teachers.include?(user) #your teacher
      css_class << " list-group-item-info"
      appearance << " (your teacher)"
    end

    link_to appearance, user_path(user), class: css_class
  end
end
