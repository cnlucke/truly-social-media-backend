class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: friend_params[:id])
    if @friendship.save
      render json: @friendship.friend
    else
      render json: { error: 'could not create friendship'}
    end
  end

  def friends
    # This currently gives back everyone you've friended and everyone who has friended you
    render json: current_user.all_friends
  end

  def destroy
    # Need to look for friendships that go either direction
    @friendship = current_user.find_friendship_by_friend_id(friend_params[:id])
    if !@friendship.empty?
      @friend = User.find_by(id: friend_params[:id])
      @friendship.each { |f| f.destroy }
      render json: @friend
    else
      render json: {error: 'unable to destroy friendship'}
    end
  end

  private

  def friend_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end
end
