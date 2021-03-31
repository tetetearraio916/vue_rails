module Jwt::TokenDecryptor
  # モジュール自身をミックスインすることで特異メソッドとしてメソッドを呼び出すことが出来る。
  # メソッドだけを呼び出したい時は、よく使われる手法らしい。
  extend self

  def call(token)
    decrypt(token)
  end

  private

  # メソッド全体が例外処理で囲まれている場合は、begin/endを省略することが出来る。
  # ただし、beginを明示してないことにより書き忘れだと思われてしまうかもしれないのでベストプラクティスと言えるのか悩ましい
  # 参照: Rubyチェリー本 P358 9.6.7
  def decrypt(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base)
  rescue StandardError
    raise InvalidTokenError
  end
end

# 独自の例外クラスをStandardErrorクラスを継承することにより作成
class InvalidTokenError < StandardError; end
