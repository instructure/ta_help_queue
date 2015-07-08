class CreatePastRequests < ActiveRecord::Migration
  def change
    create_table :past_requests do |t|
      t.integer :student_id
      t.integer :removed_by
      t.float :time_waited
      t.boolean :received_help

      t.timestamps null: false
    end
    add_index :past_requests, :student_id
    add_index :past_requests, :removed_by
  end
end
