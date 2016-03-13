require 'open-uri'

URL = 'http://google.com'
COUNT = 20

class DammyHttpResponse
  def code
    200
  end
end

def get_request
  # open(URL) do |f|
  # end
  DammyHttpResponse.new
end
