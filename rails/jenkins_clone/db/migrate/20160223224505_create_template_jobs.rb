class CreateTemplateJobs < ActiveRecord::Migration
  def change
    create_table :template_jobs do |t|
      t.string :name
      t.text :script

      t.timestamps null: false
    end
  end
end
