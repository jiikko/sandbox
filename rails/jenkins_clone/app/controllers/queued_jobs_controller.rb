class QueuedJobsController < ApplicationController
  def show
    @queued_job = QueuedJob.find(params[:id])
    @container = @queued_job.container
  end
end
