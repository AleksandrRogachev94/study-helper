module ApplicationHelper
  def header_index_page(user, content)
    if user == current_user
      "Your #{content.capitalize}"
    else
      "#{content.capitalize} of #{user.appearance}"
    end
  end

  def show_field_for(object, field, title_tag, value_tag, classes = "")
    title =  field.to_s.humanize
    value = object.send(field)
    if value.present?
      content_tag("div", class: "field") do
        concat content_tag(title_tag, title)
        concat content_tag(value_tag, value, class: classes)
      end
    else
      ""
    end
  end

  def requests_notification
    if policy_scope(Request).any?
      "*"
    else
      ""
    end
  end
end
