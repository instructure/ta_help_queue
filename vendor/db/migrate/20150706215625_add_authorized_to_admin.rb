class AddAuthorizedToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :authorized, :string
  end
end
