class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.integer :admin_id
      t.string :password
      t.string :name

      t.timestamps null: false
    end
  end
end
