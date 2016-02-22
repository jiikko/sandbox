class CreateContainerCommands < ActiveRecord::Migration
  def change
    create_table :container_commands do |t|
      t.references :container, null: false
      t.references :command_template, null: false
      t.string :name
      t.string :body
      t.string :dependency_cmds
      t.text :log
      t.integer :status_code

      t.timestamps null: false
    end
  end
end
