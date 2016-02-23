class CreateJobQueues < ActiveRecord::Migration
  def change
    create_table :job_queues do |t|
      t.references :container, null: false
      t.references :job_template, null: false
      t.string :name
      t.text :script
      t.text :log
      t.integer :status

      t.timestamps null: false
    end
  end
end
