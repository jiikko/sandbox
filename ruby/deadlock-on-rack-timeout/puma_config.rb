# kill -TERM `cat puma.pid`
# kill -USR2 `cat puma.pid`
pidfile 'puma.pid'
workers 2
preload_app!

on_worker_shutdown do
  begin 
    Timeout.timeout(3) do
      loop do
        $logger.info 'from on_worker_shutdown'
      end
    end
  rescue
  end
end
