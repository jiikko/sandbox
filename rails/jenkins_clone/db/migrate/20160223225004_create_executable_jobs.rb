class CreateExecutableJobs < ActiveRecord::Migration
  def change
    create_table :executable_jobs do |t|
      t.references :container, null: false
      t.references :template_job, null: false
      t.string :name
      t.text :script

      t.timestamps null: false
    end
  end
end
