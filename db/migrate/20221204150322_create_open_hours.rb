class CreateOpenHours < ActiveRecord::Migration[7.0]
  def change
    create_table :open_hours do |t|
      t.integer :day_of_week
      t.time :open_time
      t.time :close_time

      t.timestamps
    end
  end
end
