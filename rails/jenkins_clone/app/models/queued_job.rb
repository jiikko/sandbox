require "open3"

class QueuedJob < ActiveRecord::Base
  enum status: [:status_queued, :status_executing, :status_finished]

  belongs_to :container
  belongs_to :template_job

  def execute!
    status_executing!
    # TODO 改行毎にcapture3してtailしているように見せたい
    stdout, stderre, process_status = Open3.capture3(script % container_hash)
    self.update_columns(log: stdout + stderre, exitstatus: process_status.exitstatus)
  ensure
    self.update_columns(exitstatus: exitstatus.presence || process_status.try!(:exitstatus),
                        status: QueuedJob.statuses[:status_finished])
  end

  private

  def container_hash  # プレースホルダー用
    { branch_name: 'container.branch_name',

    }
  end
end
