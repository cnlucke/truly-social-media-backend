class AuthController < ApplicationController
  serialization_scope :view_context

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      payload = { user_id: @user.id}
      ratings = Rating.where(user_id: @user.id)
      render json: {user: UserSerializer.new(@user), token: issue_token(payload), lists: @user.lists, ratings: RatingSerializer.new(ratings)}
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
