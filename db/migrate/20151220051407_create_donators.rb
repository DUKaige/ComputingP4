class CreateDonators < ActiveRecord::Migration
  def change
    create_table :donators do |t|
      t.string :name
      t.string :user_name
      t.string :password
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
