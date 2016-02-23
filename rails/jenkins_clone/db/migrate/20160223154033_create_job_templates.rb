class CreateJobTemplates < ActiveRecord::Migration
  def change
    create_table :job_templates do |t|

      t.timestamps null: false
    end
  end
end
