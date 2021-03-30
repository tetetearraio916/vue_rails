class Api::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: { user: {id: user.id, name: user.name, email: user.email}}
    else
      render json: { error: {messages: user.errors.full_messages}}, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
