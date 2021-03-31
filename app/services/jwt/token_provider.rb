module Jwt::TokenProvider
  # モジュール自身をミックスインし、特異メソッドとしてメソッドを呼び出す。
  extend self

  def call(payload)
    issue_token(payload)
  end

  private

  def issue_token(payload)
    # ここで何かしらのアルゴリズム(HMAC、RSASSAなど)でなく、railsの秘密鍵を使って暗号化しているという解釈でいいのか？
    # (おそらく秘密鍵の暗号化のアルゴリズムを使っているんだろうな〜という解釈です)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end
end
