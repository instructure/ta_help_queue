class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :student_id

      t.timestamps null: false
    end
    add_index :requests, :student_id
  end
end
