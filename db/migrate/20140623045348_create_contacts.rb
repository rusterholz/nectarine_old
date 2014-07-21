class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.integer :age
      t.string :gender
      t.string :ethnicity
      t.text :description
      t.string :contactable_type
      t.integer :contactable_id

      t.timestamps
    end
  end
end
