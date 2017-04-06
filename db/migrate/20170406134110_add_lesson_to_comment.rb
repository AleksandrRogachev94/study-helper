class AddLessonToComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :lesson_id, :integer
  end
end
