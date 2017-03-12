class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :categories, through: :lessons
  has_many :lessons

  def lessons_by_categories
    self.lessons.group_by {|lesson| lesson.category}
  end
end
