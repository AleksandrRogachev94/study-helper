class Lesson < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :comments

  before_save :make_capitalized

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }

  def category_attributes=(attrs)
    if attrs[:title].present?
      category = Category.where("lower(title) = ?", attrs[:title]).first_or_initialize(title: attrs[:title])
      self.category = category
    end
  end

  def make_capitalized
    self.title.capitalize!
  end
end
