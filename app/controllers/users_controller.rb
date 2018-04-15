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

  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render json: {error: 'unable to update user profile' }
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

  def friend_profile
    # currently not limiting it to only current_user's friends
    @friend = User.find_by(id: params[:id])
    next_list = @friend.get_list_by_type("next")
    watching_list = @friend.get_list_by_type("watching")
    seen_list = @friend.get_list_by_type("seen")

    render json: {  user: UserSerializer.new(@friend),
                    next: next_list,
                    watching: watching_list,
                    seen: seen_list }
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end

end
