class AddLessonToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :lesson_id, :integer
    add_index :comments, :lesson_id, name: "comment_lesson_id_ix"
  end
end
