require_relative __dir__+'/../helpers'


module ReCaptcha

  # recaptcha v2 requester
  def recaptcha_v2_requester(url, siteKey)
    request_url = "https://app.metabypass.tech/CaptchaSolver/api/v1/services/bypassReCaptcha"

    params = {
      "url" => url,
      "version" => 2,
      "sitekey" => siteKey
    }

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer ' + @access_token.delete("\r\n"),
      'Accept' => 'application/json'
    }

    # send request to metabypass
    response = send_request(request_url, params, 'POST', headers)

    if response.empty?
      message = 'error! server response is empty'
      logger.error(message)
      false
    end

    response_headers = JSON.parse(response['headers'])
    response_body = JSON.parse(response['body'])

    if response_headers['http_code'] == 200
      response_body
    elsif response_headers['http_code'] == 401
      status = generate_access_token
      if status == false
        puts 'unauth'
        logger.error('unauth')
        exit
      end
      recaptcha_v2_requester(url, siteKey)
    else
      message = 'error! image captcha'
      #logger
      logger.error(message)
      false
    end
  end

  # reCaptcha v3 requester
  def recaptcha_v3_requester(url, siteKey)
    request_url = "https://app.metabypass.tech/CaptchaSolver/api/v1/services/bypassReCaptcha"

    params = {
      "url" => url,
      "version" => 3,
      "sitekey" => siteKey
    }

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer ' + @access_token.delete("\r\n"),
      'Accept' => 'application/json'
    }

    # send request to metabypass
    response = send_request(request_url, params, 'POST', headers)

    if response.empty?
      message = 'error! server response is empty'
      #logger
      logger.error(message)
      false
    end

    response_headers = JSON.parse(response['headers'])
    response_body = JSON.parse(response['body'])

    if response_headers['http_code'] == 200
      if response_body['status_code'].to_i == 200
        @end_result = response_body['data']['RecaptchaResponse']
      end
      response_body
    elsif response_headers['http_code'] == 401
      status = generate_access_token
      if status == false
        puts 'unauth'
        logger.error('unauth')
        exit
      end
      re_captcha_v3_requester(url, siteKey)
    else
      message = 'error! image captcha'
      #logger
      logger.error(message)
      false
    end
  end

  # reCaptcha v3 requester
  def re_captcha_invisible_requester(url, siteKey)
    request_url = "https://app.metabypass.tech/CaptchaSolver/api/v1/services/bypassReCaptcha"

    params = {
      "url" => url,
      "version" =>'invisible',
      "sitekey" => siteKey
    }

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer ' + @access_token.delete("\r\n"),
      'Accept' => 'application/json'
    }

    # send request to metabypass
    response = send_request(request_url, params, 'POST', headers)

    if response.empty?
      message = 'error! server response is empty'
      #logger
      logger.error(message)
      false
    end

    response_headers = JSON.parse(response['headers'])
    response_body = JSON.parse(response['body'])

    if response_headers['http_code'] == 200
      if response_body['status_code'].to_i == 200
        @end_result = response_body['data']['RecaptchaResponse']
      end
      response_body
    elsif response_headers['http_code'] == 401
      status = generate_access_token
      if status == false
        puts 'unauth'
        logger.error('unauth')
        exit
      end
      re_captcha_v3_requester(url, siteKey)
    else
      message = 'error! image captcha'
      #logger
      logger.error(message)
      false
    end
  end

  # reCaptcha get result requester
  def recaptchav2_get_result_requester(recaptcha_id)

    request_url = "https://app.metabypass.tech/CaptchaSolver/api/v1/services/getCaptchaResult"

    params = {
      "recaptcha_id" => recaptcha_id
    }

    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer ' + @access_token.delete("\r\n"),
      'Accept' => 'application/json'
    }

    # send request to metabypass
    response = send_request(request_url, params, 'GET', headers)

    if response.empty?
      message = 'error! server response is empty'

      #logger
      logger.error(message)
      false
    end

    response_headers = JSON.parse(response['headers'])
    response_body = JSON.parse(response['body'])

    if response_headers['http_code'] == 200
      if response_body['status_code'].to_i == 200
        @end_result = response_body['data']['RecaptchaResponse']
      end
      response_body
    elsif response_headers['http_code'] == 401
      status = generate_access_token
      if status == false
        puts 'unauth'
        logger.error('unauth')
        exit
      end
      recaptchav2_get_result_requester(recaptcha_id)
    else
      message = 'error! image captcha'
      #logger
      logger.error(message)
      false
    end
  end
end
