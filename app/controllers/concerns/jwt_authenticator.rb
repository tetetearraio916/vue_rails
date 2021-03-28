module JwtAuthenticator
  require 'jwt'

  SECRET_KEY_BASE = Rails.application.secrets.secret_key_base

  #暗号化
  def encode(user_id)
    #再ログインの期間
    expires_in = 1.months.from_now.to_i
    preload = { user_id: user_id, exp: expires_in }
    JWT.encode(preload, SECRET_KEY_BASE, 'HS256')
  end

  #複合化
  def decode(encoded_token)
    decoded_dwt = JWT.decode(encoded_token, SECRET_KEY_BASE, true, algorithm: 'HS256')
    decoded_dwt.first
  end
end
