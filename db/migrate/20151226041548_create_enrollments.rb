class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :child_id
      t.integer :school_id

      t.timestamps null: false
    end
  end
end
