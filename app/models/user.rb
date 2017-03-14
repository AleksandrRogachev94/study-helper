class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  has_many :categories, through: :lessons
  has_many :lessons

  # From the student view
  has_many :student_teacher_relationships, class_name: "Studyship", foreign_key: 'student_id'
  has_many :teachers, through: :student_teacher_relationships

  # From the teacher view
  has_many :teacher_student_relationships, class_name: "Studyship", foreign_key: 'teacher_id'
  has_many :students, through: :teacher_student_relationships

  has_one :profile, dependent: :destroy
  validates :profile, presence: { message: "First name and Last name can't be blank" }

  def lessons_by_categories
    self.lessons.group_by {|lesson| lesson.category}
  end

  def profile_attributes=(attrs)
    # raise attrs.inspect
    # if attrs[:title].present?
    #   category = Category.where("lower(title) = ?", attrs[:title]).first_or_create(title: attrs[:title])
    #   self.category = category
    #   self.save
    # end
  end
end
