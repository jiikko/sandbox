class CreateDoclerContainers < ActiveRecord::Migration
  def change
    create_table :docler_containers do |t|
      t.string :name
      t.text :log

      t.timestamps null: false
    end
  end
end
