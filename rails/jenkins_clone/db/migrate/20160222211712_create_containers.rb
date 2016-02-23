class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :workers_count
      t.boolean :status

      t.timestamps null: false
    end
  end
end
