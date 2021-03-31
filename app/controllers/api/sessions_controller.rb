class Api::SessionsController < ApplicationController

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      token = Jwt::TokenProvider.call(user_id: user.id)
      render json: { user: ActiveModelSerializers::SerializableResource.new(user, adapter: :attributes).as_json.deep_merge(token: token)  }
    else
      render json: { error: { messages: ['メールアドレスまたはパスワードに誤りがあります'] } }, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
