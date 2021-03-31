class ApplicationController < ActionController::Base
  # CSRFトークンがリクエスト元と一致しなかった場合、例外ではなくセッションを空にする。
  # これによりAPIの機能を実装することが出来る。RailsのAPIモードであれば記述する必要はなし。(今回は異なる)
  protect_from_forgery with: :null_session

  # 　独自の認証エラーを作成
  class AuthenticationError < StandardError; end

  # バリデーションの例外が発生した場合は、render_422を呼び出す
  rescue_from ActiveRecord::RecordInvalid, with: :render_422
  # 認証の例外が発生した場合は、not_authenticatedを呼び出す
  rescue_from AuthenticationError, with: :not_authenticated

  # 各コントローラに対して認証
  def authenticate
    raise AuthenticationError unless current_user
  end

  # トークンの有無でユーザー認証
  def current_user
    @current_user ||= Jwt::UserAuthenticator.call(request.headers)
  end

  private

  # rescue_fromの例外を引数に取る。その例外のエラーメッセージをjsonで返す。
  def render_422(exception)
    # :unprocessable_entityは、rails特有のステータスコードの表記。
    render json: { error: { messages: exception.record.errors.full_messages } }, status: :unprocessable_entity
  end

  # rescue_fromの例外を引数に取る。その例外のエラーメッセージをjsonで返す。
  def not_authenticated
    # :unauthorizedは、認証が必要な場合に返す(401)
    render json: { error: { messages: ['ログインしてください'] } }, status: :unauthorized
  end
end
