class ExecutableJob < ActiveRecord::Base
  belongs_to :container
  belongs_to :template_job

  def execute!
    queued_job = container.queued_jobs.create!(
      status: QueuedJob.statuses[:status_queued],
      name: name,
      script: script,
    )
    queued_job.delay.execute!
    queued_job
  end
end
