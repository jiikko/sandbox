class CreateCommandTemplates < ActiveRecord::Migration
  def change
    create_table :command_templates do |t|
      t.string :name
      t.string :body
      t.string :dependency_cmds

      t.timestamps null: false
    end
  end
end
