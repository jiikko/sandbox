class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.string :name
      t.integer :prosess_count
      t.text :log

      t.timestamps null: false
    end
  end
end
