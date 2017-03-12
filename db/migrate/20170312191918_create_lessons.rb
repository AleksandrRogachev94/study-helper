class CreateLessons < ActiveRecord::Migration[5.0]
  def change
    create_table :lessons do |t|
      t.string :title
      t.text :description
      t.text :content
      t.text :links
      t.integer :category_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
