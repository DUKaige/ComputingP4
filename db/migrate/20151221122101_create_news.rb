class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.string :content
      t.integer :child_id

      t.timestamps
    end
  end
end
