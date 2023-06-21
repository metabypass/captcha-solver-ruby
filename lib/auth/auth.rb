require_relative __dir__+"/../helpers"
require 'net/http'
require 'json'


class Auth

  # attr_reader :email, :password, :client_id, :client_secret,

  def initialize(client_id,client_secret,email,password)
    @client_id = client_id
    @client_secret = client_secret
    @password = password
    @email = email
    @access_token_file_path = File.join(__dir__, 'metabypass.token')
    @access_token = retrieve_access_token || generate_access_token
  end


  def generate_access_token

    request_url = 'https://app.metabypass.tech/CaptchaSolver/oauth/token'

    params = {
      'grant_type' => 'password',
      'client_id' => @client_id,
      'client_secret' => @client_secret,
      'username' => @email,
      'password' => @password
    }

    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    #webservice response
    response = send_request(request_url, params, 'POST', headers)

    if response.empty?
      message = 'error! server response is empty'

      #logger
      logger.error(message)
      return false
    end


    headers = JSON.parse(response['headers'])
    body = JSON.parse(response['body'])

    if headers['http_code'] == 200
      @access_token = body['access_token']

      File.write(@access_token_file_path, body['access_token'])
      return body['access_token']
    else
      message = 'error! unauth'
      #logger
      logger.error(message)
      return false
    end

  end

  private

  def retrieve_access_token
    File.read(@access_token_file_path) if File.exist?(@access_token_file_path)
  end

end
