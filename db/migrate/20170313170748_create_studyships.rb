class CreateStudyships < ActiveRecord::Migration[5.0]
  def change
    create_table :studyships do |t|
      t.integer :teacher_id
      t.integer :student_id

      t.timestamps
    end

    add_index :studyships, :tacher_id, name: "teacher_id_ix"
    add_index :studyships, :student_id, name: "student_id_ix"
  end
end
