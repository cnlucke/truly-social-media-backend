class UsersController < ApplicationController
  serialization_scope :view_context

  def index
    @users = User.all
    render json: @users
  end

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

    render json: {  user: UserSerializer.new(current_user),
                    friends: current_user.friends,
                    all_users: User.all,
                    next: next_list,
                    watching: watching_list,
                    seen: seen_list }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :city, :state)
  end

end
