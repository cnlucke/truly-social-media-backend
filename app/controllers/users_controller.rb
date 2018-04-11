class UsersController < ApplicationController
  serialization_scope :view_context

  def create
    @user = User.new(user_params)
    if @user.save
      payload = { user_id: @user.id}
      render json: {user: UserSerializer.new(@user), token: issue_token(payload)}
    else
      render json: {error: @user.errors.full_messages}
    end
  end

  def profile
    next_list = current_user.get_list_by_type("next")
    watching_list = current_user.get_list_by_type("watching")
    seen_list = current_user.get_list_by_type("seen")

    render json: { user: UserSerializer.new(current_user), next: next_list, watching: watching_list, seen: seen_list }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :city, :state)
  end

end
