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
    `ls`
    `ls`
    `ls`
    `ls`
    self.update_column(:log, "out.sting")
  end
end
