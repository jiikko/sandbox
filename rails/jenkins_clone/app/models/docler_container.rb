class DoclerContainer < ActiveRecord::Base
  def test
    cmd = <<-CMD
ls
sleep 2
ls
    CMD
    system(cmd)
  end

  def run
    ensure_run do
    end
  end

  def ensure_run
    yield
  end
end
