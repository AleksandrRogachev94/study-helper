class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.integer :age
      t.string :study_place
      t.string :degree
      t.string :interests
      t.integer :user_id

      t.timestamps
    end

    add_index :profiles, :user_id, name: "profile_user_id_ix"
  end
end
