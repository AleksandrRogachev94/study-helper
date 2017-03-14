module ApplicationHelper
  def header_index_page(user, content)
    if user == current_user
      "Your #{content.capitalize}"
    else
      "#{content.capitalize} of #{user.email}"
    end
  end

  def show_field_for(object, field, tag)
    title =  field.to_s.humanize
    value = object.send(field)
    value.present? ? content_tag(tag,"#{title}: #{value}") : ""
  end
end
