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

    Open3.popen3("echo a; sleep 1; echo b; sort >&2; sleep 3") do |i, o, e, w|
      i.write "foo\nbar\nbaz\n"
      i.close
      o.each do |line| p line end #=> "a\n",  "b\n"
      e.each do |line| p line end #=> "bar\n", "baz\n", "foo\n"
      p w.value #=> #<Process::Status: pid 32682 exit 0>
    end
    `ls`
    `ls`
    `ls`
    `ls`
    self.update_column(:log, "out.sting")
  end
end
