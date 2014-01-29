class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string  :name
      t.integer :form
      t.integer :number
      t.string  :classroom
      t.integer :day
      t.integer :start_week
      t.integer :end_week
      t.integer :group_id

      t.timestamps
    end
  end
end
