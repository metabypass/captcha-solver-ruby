require_relative __dir__+'/../helpers'

module CaptchaSolver

  def image_captcha_requester(image, numeric = 0, min_len = 0, max_len = 0)

    request_url = 'https://app.metabypass.tech/CaptchaSolver/api/v1/services/captchaSolver'

    params = {
      'image' => image,
      'numeric' => numeric,
      'min_len' => min_len,
      'max_len' => max_len
    }

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer ' + @access_token.delete("\r\n"),
      'Accept' => 'application/json'
    }

    response = send_request(request_url, params, 'POST', headers)



    if response.empty?
      message = 'error! server response is empty'
      logger.error(message)
      false
    end

    response_headers = JSON.parse(response['headers'])
    response_body = JSON.parse(response['body'])

    if response_headers['http_code'] == 200
      if response_body['status_code'].to_i == 200
        @end_result = response_body['data']['result']
      end
      response_body
    elsif response_headers['http_code'] == 401
      status = generate_access_token
      if status == false
        puts 'unauth'
        exit
      end
      image_captcha_requester(image, numeric, min_len, max_len)
    else
      message = 'error! image captcha'
      #logger
      logger.error(message)
      false
    end
  end
end
