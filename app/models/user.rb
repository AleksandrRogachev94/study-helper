class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :categories, through: :lessons
  has_many :lessons

  # From the student view
  has_many :student_teacher_relationships, class_name: "Studyship", foreign_key: 'student_id'
  has_many :teachers, through: :student_teacher_relationships

  # From the teacher view
  has_many :teacher_student_relationships, class_name: "Studyship", foreign_key: 'teacher_id'
  has_many :students, through: :teacher_student_relationships

  has_one :profile, dependent: :destroy
  validates :profile, presence: true

  delegate :full_name, to: :profile

  def lessons_by_categories
    self.lessons.group_by {|lesson| lesson.category}
  end

  def profile_attributes=(attrs)
    profile = Profile.new(attrs)
    self.profile = profile
    self.profile = nil if !profile.save
  end

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    profile = user.build_profile(full_name: auth.info.name, image: auth.info.image)
    profile.save(:validate => false)
  end
end
end
