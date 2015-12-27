class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :user_name
      t.string :password
      t.string :email
      t.string :phone_number
      t.string :address
      t.string :card_number

      t.timestamps null: false
    end
  end
end
