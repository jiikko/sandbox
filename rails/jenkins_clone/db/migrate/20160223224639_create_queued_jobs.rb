class CreateQueuedJobs < ActiveRecord::Migration
  def change
    create_table :queued_jobs do |t|
      t.references :container, null: false
      t.string :name
      t.text :script
      t.text :log
      t.integer :status

      t.timestamps null: false
    end
  end
end
