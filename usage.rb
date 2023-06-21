require_relative __dir__+'/lib/metabypass'


# ---------------------------- CREDENTIALS -----------------------------

client_id = 'YOUR_CLIENT_ID'
client_secret = 'YOUR_CLIENT_SECRET'
email = 'YOUR_EMAIL'
password = 'YOUR_PASSWORD'



# Metabypass instance
metabypass = Metabypass.new(client_id,client_secret,email,password)


# ----------------------------IMAGE CAPTCHA SAMPLE -----------------------------
img="samples/icaptcha1.jpg"
numeric=0; #default
min_len=0;  #default
max_len=0;  #default
image_captcha= metabypass.image_captcha(img,numeric,min_len,max_len)
puts metabypass.end_result


# # --------------------------- reCAPTCHA V2 SAMPLE -----------------------------
# url="SITE_URL"
# sitekey="SITE_KEY"
# recaptcha_v2= metabypass.recaptcha_v2_handler(url,sitekey)
# puts metabypass.end_result

# --------------------------- reCAPTCHA V3 SAMPLE -----------------------------
# url="SITE_URL"
# sitekey="SITE_KEY"
# recaptcha_v3= metabypass.recaptcha_v3(url,sitekey)
# puts metabypass.end_result


# --------------------------- reCAPTCHA INVISIBLE SAMPLE -----------------------------
# url="SITE_URL"
# sitekey="SITE_KEY"
# recaptcha_invisible= metabypass.recaptcha_invisible(url,sitekey)
# puts metabypass.end_result


