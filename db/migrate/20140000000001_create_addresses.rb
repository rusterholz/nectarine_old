class CreateAddresses < ActiveRecord::Migration
  
  def change

    create_table :addresses do |t|

      t.string  :addressable_type
      t.integer :addressable_id
      t.string  :title
      t.string  :line1
      t.string  :line2
      t.string  :city
      t.string  :state
      t.string  :zip
      t.string  :country
      t.string  :phone
      t.float   :latitude
      t.float   :longitude

      t.timestamps

    end

    add_index :addresses, [ :addressable_type, :addressable_id ], name: 'index_addresses_on_addressable'

  end
end


      