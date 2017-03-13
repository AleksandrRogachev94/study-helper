module ApplicationHelper
  def header_index_page(user, content)
    if user == current_user
      "Your #{content.capitalize}"
    else
      "#{content.capitalize} of #{user.email}"
    end
  end
end
