class Profile < ApplicationRecord

  belongs_to :user

  before_save :capitalize_name

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def capitalize_name
    self.first_name.capitalize!
    self.last_name.capitalize!
  end
end
