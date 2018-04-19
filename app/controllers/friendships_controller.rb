class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.find_by(user_id: current_user[:id], friend_id: friend_params[:id])
    if friendship #friendship record already exists
      render json: friendship.friend
    else
      friendship = current_user.friendships.build(friend_id: friend_params[:id])

      if friendship.save
        notify Act::ACT_FRIENDSHIP_CREATED, friendship

        ActivityFeedChannel.broadcast_to(Act.order('id').first, {
          type: 'SET_ACTIVITY',
          payload: Act.hash_with_bodies
          })

        render json: friendship.friend
      else
        render json: { error: 'could not create friendship'}
      end
    end
  end

  def friends
    # This currently gives back everyone you've friended and everyone who has friended you
    render json: current_user.all_friends.map { |f| UserSerializer.new(f)  }
  end

  def destroy
    # Need to look for friendships that go either direction
    friendship = current_user.find_friendship_by_friend_id(friend_params[:id])
    if !friendship.empty?
      friend = User.find_by(id: friend_params[:id])
      friendship.each { |f| f.destroy }
      render json: friend
    else
      render json: {error: 'unable to destroy friendship'}
    end
  end

  private

  def friend_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end
end
