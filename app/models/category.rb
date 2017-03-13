class Category < ApplicationRecord
  has_many :lessons
  has_many :users, through: :lessons

  validates :title, uniqueness: { case_sensitive: false }
end
