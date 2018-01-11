workers Integer(ENV['PUMA_WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!
rackup      DefaultRackup

on_worker_boot do
  # pid ファイルを書き出しすぐにTERMできるようにする
  puts 'start...'
  sleep(2)
  puts 'ok'
end

on_worker_shutdown do
  puts 'shutdown...'
  sleep(2)
  puts 'bey'
end
