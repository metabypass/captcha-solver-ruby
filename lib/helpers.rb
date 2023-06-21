require 'net/http'
require 'uri'


def send_request(url, params, method, headers)

  #prepare
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true if uri.scheme == 'https'

  #method types
  case method
    when 'GET'
      uri.query = URI.encode_www_form(params)
      request = Net::HTTP::Get.new(uri)
    when 'POST'
      request = Net::HTTP::Post.new(uri)
      request.body = params.to_json
    when 'PUT'
      request = Net::HTTP::Put.new(uri)
      request.body = params.to_json
    when 'DELETE'
      uri.query = URI.encode_www_form(params)
      request = Net::HTTP::Delete.new(uri)
    else
      return {}
  end

  headers.each { |key, value| request[key] = value }

  response = http.request(request)

  headers= response.to_hash
  headers['http_code']=response.code.to_i

  {
    'headers' =>headers.to_json,
    'body' => response.body
  }

end

def is_base64_format?(str)

  # Remove whitespace characters from the string
  cleaned_str = str.gsub(/\s+/, '')

  # Check if the cleaned string is in the valid base64 format
  # by matching it against the base64 regular expression pattern
  base64_pattern = /^[a-zA-Z0-9+\/]+={0,2}$/
  base64_pattern.match?(cleaned_str)
end
