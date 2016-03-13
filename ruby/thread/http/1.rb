require './http_helper'

results = []
COUNT.times do
  response = get_request
  results.push response.code
end
puts results.inspect
