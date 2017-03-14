class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.text :description

      t.timestamps null: false
    end

    add_index :requests, :teacher_id, name: "request_teacher_id_ix"
    add_index :requests, :student_id, name: "request_student_id_ix"
  end
end
