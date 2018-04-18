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
    recommended_items = friend_recommended_ratings.map { |r| Item.find(r.item_id)}.uniq
    sorted_recommended_items = (recommended_items.sort_by &:rating).reverse
    friend_ratings = current_user.friend_ratings
    ratings = current_user.ratings

    render json: {
                    user: UserSerializer.new(current_user),
                    rating: RatingSerializer.new(ratings[0]),
                    friends: current_user.all_friends.map { |r| UserSerializer.new(r)},
                    all_users: all_users.map { |r| UserSerializer.new(r)},
                    next: next_list.map { |r| ItemSerializer.new(r)},
                    watching: watching_list.map { |r| ItemSerializer.new(r)},
                    seen: seen_list.map { |r| ItemSerializer.new(r)},
                    ratings: ratings.map { |r| RatingSerializer.new(r)},
                    friend_ratings: friend_ratings, each_serializer: RatingSerializer,
                    recommended: sorted_recommended_items.map { |r| ItemSerializer.new(r)}
                   }
  end

  def friend_profile
    # currently not limiting it to only current_user's friends
    friend = User.find_by(id: params[:id])
    next_list = friend.get_list_by_type("next")
    watching_list = friend.get_list_by_type("watching")
    seen_list = friend.get_list_by_type("seen")
    ratings = Rating.where(user_id: friend.id)

    render json: {
                    user: UserSerializer.new(friend),
                    next: next_list.map { |r| ItemSerializer.new(r)},
                    watching: watching_list.map { |r| ItemSerializer.new(r)},
                    seen: seen_list.map { |r| ItemSerializer.new(r)},
                    ratings: ratings.map { |r| RatingSerializer.new(r)}
                  }
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end

end
