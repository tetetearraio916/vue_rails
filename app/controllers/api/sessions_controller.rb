class Api::SessionsController < ApplicationController
  include JwtAuthenticator

  def create
    @current_user = User.find_by(email: session_params[:email])
    if @current_user&.authenticate(session_params[:password])
      jwt_token = encode(@current_user.id)
      response.headers['X-authenticate-token'] = jwt_token
      render json: {user: {id: @current_user.id, name: @current_user.name, email: @current_user.email, token: jwt_token}}
    else
      render json: { error: {messages: ['メールアドレスまたはパスワードに誤りがあります']}}, status: 401
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
