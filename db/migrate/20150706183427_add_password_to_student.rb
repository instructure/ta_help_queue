class AddPasswordToStudent < ActiveRecord::Migration
  def change
    add_column :students, :password, :string
  end
end
