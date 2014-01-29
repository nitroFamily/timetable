class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :groups, :remember_token, :string
    add_index  :groups, :remember_token
  end
end
