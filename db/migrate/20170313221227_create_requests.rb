class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.integer :student_id
      t.integer :teacher_id
      t.text :description

      t.timestamps null: false
    end
  end
end
