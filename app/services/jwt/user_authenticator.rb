module Jwt::UserAuthenticator
  extend self

  def call(request_headers)
    @request_headers = request_headers
    begin
      # トークンをデコードする
      payload = Jwt::TokenDecryptor.call(token)
      User.find(payload['user_id'])
    rescue StandardError #StandardErrorの例外を捉えた時にはnilを返す。
      nil
    end
  end

  private

  def token
    # headers['Authorization'] = "Bearer XXXXX..."のようになっているので、splitとlastを用いてXXXXの部分のトークンを取得する
    @request_headers['Authorization'].split(' ').last
  end
end
