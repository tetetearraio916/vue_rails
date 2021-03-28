class Api::UsersController < ApplicationController

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: { error: {messages: user.errors.full_messages}}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
