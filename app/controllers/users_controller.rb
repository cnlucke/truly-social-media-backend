class UsersController < ApplicationController
  serialization_scope :view_context

  def create
    @user = User.new(user_params)
    if @user.save
      # SUCCESSFUL CREATION
      payload = { user_id: @user.id}
      render json: {user: UserSerializer.new(@user), token: issue_token(payload)}
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  def profile
    # payload = { user_id: current_user.id }
    # render json: {user: UserSerializer.new(current_user), token: issue_token(payload)}
    render json: { user: UserSerializer.new(current_user), lists: current_user.lists }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :city, :state)
  end

end
