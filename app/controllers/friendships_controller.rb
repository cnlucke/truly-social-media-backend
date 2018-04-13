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
    render json: current_user.friends
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: friend_params[:id])
    if @friendship.destroy
      render json: @friendship.friend
    else
      render json: {error: 'unable to add friendship'}
    end
  end

  private

  def friend_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :city, :state)
  end
end
