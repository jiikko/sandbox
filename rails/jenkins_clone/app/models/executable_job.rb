class ExecutableJob < ActiveRecord::Base
  belongs_to :container
  belongs_to :template_job

  def execute!
    container.queued_jobs.create!(
      name: name,
      script: script,
    )
  end
end
