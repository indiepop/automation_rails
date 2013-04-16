# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
AutomationRails::Application.config.secret_token = 'f2cc2c07397cab81f0f6c79ad095d94746b3fe4f120c2dfce0e4092a422e873b9729859623416818a737ced1c2a1a715f1025b90aab70b775f45c05b8522857f'
# 包括了亂數產生的一組 key 用來編碼需要保護的 Cookie 訊息(例如下述的 Cookie session)。
# 修改這組 key 會讓已經存放在使用者瀏覽器上的 Cookie Session 和 Signed Cookie 失效。你可以用來強制使用者需要重新登入。
