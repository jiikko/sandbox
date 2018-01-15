interval = 10

Thread.start do
  loop do
    sleep interval
    pid = File.read('puma.pid')
    system `kill -USR2 #{pid}`
  end
end
