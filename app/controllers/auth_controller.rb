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

      render json: {  user: UserSerializer.new(user),
                      friends: user.all_friends,
                      all_users: all_users,
                      next: next_list,
                      watching: watching_list,
                      seen: seen_list,
                      ratings: user.ratings, each_serializer: RatingSerializer,
                      friend_ratings: user.friend_ratings,
                      token: issue_token(payload)}
    else
      render json: {error: "could not authenticate user"}
    end
  end

  def show
    if current_user
      render json: current_user
    else
      render json: {error: "could not authenticate"}
    end
  end

end
