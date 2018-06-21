workers Integer(2)
threads_count = Integer(5)
threads threads_count, threads_count

preload_app!
rackup DefaultRackup

on_worker_boot do
  SQLLogger::Queue.start
  sleep(4)
end

on_worker_shutdown do
  sleep(5)
  puts 'shutdown...'
end
