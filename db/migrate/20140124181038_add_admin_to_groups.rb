class AddAdminToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :admin, :boolean, default: false
  end
end
