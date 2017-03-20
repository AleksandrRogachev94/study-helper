class AddIndexesToAssociations < ActiveRecord::Migration[5.0]
  def change
    add_index :lessons, :user_id, name: "lesson_user_id_ix"
    add_index :lessons, :category_id, name: "lesson_category_id_ix"
  end
end
