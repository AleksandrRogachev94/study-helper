class AddIndexesToAssociations < ActiveRecord::Migration[5.0]
  def change
    add_index :lessons, :user_id, name: "user_id_ix"
    add_index :lessons, :category_id, name: "category_id_ix"
  end
end
