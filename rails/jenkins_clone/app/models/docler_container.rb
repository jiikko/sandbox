require "open3"

class DoclerContainer < ActiveRecord::Base
  def test
    cmd = <<-CMD
ls
sleep 2
ls
    CMD
    system(cmd)
  end

  def hai
    stdin, stdout, stderr, wait_thr = Open3.popen3()
    self.update_column(:log, stdout.read + stderr.read)
  end
end
