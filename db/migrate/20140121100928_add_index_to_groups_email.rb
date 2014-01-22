class AddIndexToGroupsEmail < ActiveRecord::Migration
  def change
  	add_index :groups, :email, unique: true
  end
end
