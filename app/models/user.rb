class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :categories, through: :lessons
  has_many :lessons

  # As a student
  has_many :student_teacher_relationships, class_name: "Studyship", foreign_key: 'student_id'
  has_many :teachers, through: :student_teacher_relationships

  # As a teacher
  has_many :teacher_student_relationships, class_name: "Studyship", foreign_key: 'teacher_id'
  has_many :students, through: :teacher_student_relationships

  has_one :profile, dependent: :destroy
  validates :profile, presence: true

  delegate :full_name, to: :profile

  def appearance
    self.full_name || self.email
  end

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

  def self.search(search)
    return self.all if search.blank?

    # Search in profiles first.
    result = Profile.where("last_name LIKE ?", "%#{search}%").map(&:user)
    if result.empty?
     Profile.where("first_name LIKE ?", "%#{search}%").map(&:user)
    end
    if result.empty?
      #Search in credentials.
      result = self.where("email LIKE ?", "%#{search}%")
    end

    result
  end

  def self.most_popular_teachers(limit)
    self.select('users.*, count(users.id) AS students_count').joins(teacher_student_relationships: :student)
                                                             .group(:id).order('students_count DESC').limit(limit)
  end
end
