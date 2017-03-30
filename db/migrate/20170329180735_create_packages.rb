class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.text :from_name
      t.text :from_address
      t.text :from_city
      t.text :from_state
      t.text :from_country
      t.text :from_zip
      t.text :from_phone

      t.text :to_name
      t.text :to_address
      t.text :to_city
      t.text :to_state
      t.text :to_country
      t.text :to_zip
      t.text :to_phone
      
      t.timestamps null: false
    end
  end
end
