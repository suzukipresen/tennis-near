class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :event_date
      t.string :place
      t.integer :level
      t.integer :fee
      t.text :description
      t.integer :capacity
      t.boolean :beginner_friendly

      t.timestamps
    end
  end
end
