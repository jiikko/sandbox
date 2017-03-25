#!/bin/sh

server_code=$(cat <<-RUBY
require 'drb'
URI = 'druby://localhost:8787'
list = [1, 2, 3, 4, 5]
FRONT_OBJECT = list
DRb.start_service(URI, FRONT_OBJECT, safe_level: 1)
DRb.thread.join
RUBY
)
echo "$server_code" | ruby -r drb &

client_code=$(cat <<-RUBY
require 'drb'
SERVER_URI = 'druby://localhost:8787'
DRb.start_service
item = DRbObject.new_with_uri(SERVER_URI)
puts item
RUBY
)
echo "$client_code" | ruby -r drb &

client_code2=$(cat <<-RUBY
require 'drb'
SERVER_URI = 'druby://localhost:8787'
DRb.start_service
item = DRbObject.new_with_uri(SERVER_URI)
puts item
RUBY
)
echo "$client_code2" | ruby -r drb &
