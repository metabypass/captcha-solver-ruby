require_relative __dir__+'/helpers'
require_relative __dir__+'/auth/auth'
require_relative __dir__+'/modules/captcha_solver'
require_relative __dir__+'/modules/recaptcha'
require 'base64'
include CaptchaSolver
include ReCaptcha
require 'logger'




class Metabypass < Auth

  attr_accessor :end_result, :logger , :logger_file_path


  def initialize(client_id,client_secret,email,password)
    @end_result = nil
    @logger_file_path=__dir__+'/../metabypass.log'
    @logger = Logger.new(@logger_file_path)
    super(client_id,client_secret,email,password)
  end


  # Image captcha requester
  def image_captcha(image, numeric = 0, minLen = 0, maxLen = 0)

    @end_result=nil

    # Check if the image is a file or base64
    if File.exist?(image)

      begin

        context = File.binread(image)
        base64EncodedFile = Base64.encode64(context).delete("\r\n")

      rescue Errno::ENOENT => e
        #logger
        message='file did not read'
        logger.error(message)
        false
      end

    elsif is_base64_format?(image)
      base64EncodedFile = image
    else
      #logger
      message='invalid image. pass image path or valid base64 of image'
      logger.error(message)
      false
    end

    image_captcha_requester(base64EncodedFile, numeric, minLen, maxLen)

  end


  # Simple reCaptcha v2 requester without handling the result
  def recaptcha_v2(url, siteKey)
    @end_result=nil
    # This is just an API caller for developers
    recaptcha_v2_requester(url, siteKey)
  end


  # reCaptcha v2 requester & result handler
  def recaptcha_v2_handler(url, siteKey)

    @end_result=nil
    # Request reCaptcha v2 API
    recaptcha_response = recaptcha_v2_requester(url, siteKey)

    false unless recaptcha_response

    if recaptcha_response['data']['RecaptchaId'].nil?
      #logger
      mwssage='invalid reCaptcha v2 response. RecaptchaId not found in response body. '
      logger.error(message)
      message
      false
    end

    result=nil
    # Handle getting the result (max: 100 seconds)
    puts "to get result wait 10 seconds ... (to disable this message go to metabypass.rb file and comment line #{__LINE__})"
    10.times do

      # Sleep for 10 seconds to get the result
      sleep(10)

      # Request get result API
      result = recaptchav2_get_result_requester(recaptcha_response['data']['RecaptchaId'])
      # puts result.inspect # Show get result response

      if result['status_code'] == 200
        break
      else
        @end_result = false
        puts "reCAPTCHA result not ready. Wait 10 seconds again... (to disable this message go to metabypass.rb file and comment line #{__LINE__})"
      end
    end

    result
  end


  # reCaptcha v3 requester
  def recaptcha_v3(url, siteKey)
    @end_result=nil
    recaptcha_v3_requester(url, siteKey)
  end


  # reCaptcha invisible requester
  def recaptcha_invisible(url, siteKey)
    @end_result=nil
    re_captcha_invisible_requester(url, siteKey)
  end

end
