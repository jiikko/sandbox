require "open3"

class QueuedJob < ActiveRecord::Base
  belongs_to :container
  belongs_to :template_job

  def execute!
    stdin, stdout, stderr, wait_thr = Open3.popen3(script % container_hash)
    self.update_columns(log: stdout.try!(:read) + stderr.try!(:read), status: $?.try(:exitstatus))
  end

  private

  def container_hash  # プレースホルダー用
    { branch_name: 'container.branch_name',

    }
  end
end
