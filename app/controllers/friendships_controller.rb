class FriendshipsController < ApplicationController
  def create
    # @friendship = current_user.frienships.build(:friend_id)
    @friendship = Friendship.new(params[:friendship])
    if @friendship.save
      # successfully created friendship, render api success response
    else
      #render error
    end
  end

  def destroy
    #@friendship = current_user.friendships.find(params[:id]) -- can only destroy current user friendships
    @friendship = Friendship.find(params[:id]) #insecure because you can destroy any friendship
    @friendship.destroy
    # render success response
  end

end
