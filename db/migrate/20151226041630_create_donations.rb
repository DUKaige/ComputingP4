class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.integer :donator_id
      t.integer :child_id
      t.string  :status
      t.timestamps null: false
    end
  end
end
