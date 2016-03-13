require 'uri'
require 'net/http'
require 'openssl'

URL = 'http://google.com'
COUNT = 20

def get_request
  uri = URI.parse(URL)
  Net::HTTP.start(uri.host, uri.port,
                  open_timeout: 5,
                  read_timeout: 5,
                  use_ssl: uri.scheme == 'https',
                  ssl_version: :TLSv1,
                  verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
    response = http.get(uri.request_uri)
    return response
  end
end
