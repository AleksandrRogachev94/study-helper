class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  def category_attributes=(attrs)
  end
end
