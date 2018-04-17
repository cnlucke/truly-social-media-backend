class AuthController < ApplicationController
  serialization_scope :view_context

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      payload = { user_id: user.id}
      next_list = user.get_list_by_type("next")
      watching_list = user.get_list_by_type("watching")
      seen_list = user.get_list_by_type("seen")
      all_users = User.select { |u| u.id != user.id }
      friend_ratings = user.friend_ratings
      ratings = user.ratings
      friend_recommended_ratings = user.friend_ratings.select { |r| r.rating >= 9 }
      # currently does not persist who recommends it
      recommended_items = friend_recommended_ratings.map { |r| Item.find(r.item_id)}
      sorted_recommended_items = (recommended_items.sort_by &:rating).reverse

      render json: {  user: UserSerializer.new(user),
                      rating: RatingSerializer.new(ratings[0]),
                      friends: user.all_friends.map { |r| UserSerializer.new(r)},
                      all_users: all_users.map { |r| UserSerializer.new(r)},
                      next: next_list.map { |r| ItemSerializer.new(r)},
                      watching: watching_list.map { |r| ItemSerializer.new(r)},
                      seen: seen_list.map { |r| ItemSerializer.new(r)},
                      ratings: ratings.map { |r| RatingSerializer.new(r)},
                      friend_ratings: friend_ratings, each_serializer: RatingSerializer,
                      recommended: sorted_recommended_items.map { |r| ItemSerializer.new(r)},
                      token: issue_token(payload)
                     }
    else
      render json: {error: "could not authenticate user"}
    end
  end
end
