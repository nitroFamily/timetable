class AddPeriodicityToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :periodicity, :integer
  end
end
