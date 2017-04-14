class Category < ApplicationRecord
  has_many :lessons
  has_many :authors, through: :lessons

  before_save :capitalize_title

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  def capitalize_title
    self.title.capitalize!
  end

  def self.search(search)
    if search
      self.where("title LIKE ?", "%#{search}%")
    else
      self.all
    end
  end
end
