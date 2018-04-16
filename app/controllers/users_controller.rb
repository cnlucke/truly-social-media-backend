class UsersController < ApplicationController
  serialization_scope :view_context

  def create
    @user = User.new(user_params)
    if @user.save
      payload = { user_id: @user.id}
      render json: {user: UserSerializer.new(@user), token: issue_token(payload)}
    else
      render json: { error: @user.errors }
    end
  end

  def update
    if current_user.update(user_params)
      render json: current_user
    else
      render status: 400
    end
  end

  def profile
    all_users = User.select { |u| u.id != current_user.id }
    next_list = current_user.get_list_by_type("next")
    watching_list = current_user.get_list_by_type("watching")
    seen_list = current_user.get_list_by_type("seen")
    friend_recommended_ratings = current_user.friend_ratings.select { |r| r.rating >= 9 }
    # currently does not persist who recommends it
    recommended_items = friend_recommended_ratings.map { |r| Item.find(r.item_id)}
    sorted_recommended_items = (recommended_items.sort_by &:rating).reverse

    render json: {  user: UserSerializer.new(current_user),
                    friends: current_user.all_friends,
                    all_users: all_users,
                    next: next_list,
                    watching: watching_list,
                    seen: seen_list,
                    ratings: current_user.ratings, each_serializer: RatingSerializer,
                    friend_ratings: current_user.friend_ratings,
                    recommended: sorted_recommended_items }
  end

  def friend_profile
    # currently not limiting it to only current_user's friends
    friend = User.find_by(id: params[:id])
    next_list = friend.get_list_by_type("next")
    watching_list = friend.get_list_by_type("watching")
    seen_list = friend.get_list_by_type("seen")
    ratings = Rating.where(user_id: friend.id)

    render json: {  user: UserSerializer.new(friend),
                    next: next_list,
                    watching: watching_list,
                    seen: seen_list,
                    ratings: ratings, each_serializer: RatingSerializer }
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end

end
