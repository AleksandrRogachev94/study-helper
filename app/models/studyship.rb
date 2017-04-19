class Studyship < ApplicationRecord
  belongs_to :teacher, class_name: "User"
  belongs_to :student, class_name: "User"

  def self.establish_mutual_relationships(teacher:, student:)
    return false if teacher.nil? || student.nil?
    return false if !teacher.is_a?(User) || !student.is_a?(User) || teacher == student
    return false if teacher.students.include?(student)

    teacher_student = teacher.teacher_student_relationships.create(student: student)

    if (teacher_student && !teacher_student.errors.any?)
      teacher_student
    else
      nil
    end
  end
end
