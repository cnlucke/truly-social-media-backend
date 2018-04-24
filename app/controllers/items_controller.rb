class ItemsController < ApplicationController
  def rate
    item = current_user.items.find(item_params[:id])
    rating = Rating.find_by(user_id: current_user.id, item_id: item.id)
    if rating
      notify Act::ACT_ITEM_RATED, rating

      ActivityFeedChannel.broadcast_to(Act.order('id').first, {
        type: 'SET_ACTIVITY',
        payload: current_user.relevant_acts
        })

      rating.update(rating: item_params[:rating])
    else
      rating = Rating.create(user_id: current_user.id, item_id: item.id, rating: item_params[:rating])
      notify Act::ACT_ITEM_RATED, rating

      ActivityFeedChannel.broadcast_to(Act.order('id').first, {
        type: 'SET_ACTIVITY',
        payload: current_user.relevant_acts
        })
    end
    # need to return updated item and new rating record
    render json: { item: item, rating: RatingSerializer.new(rating) }
  end

  def friends_with_item
    friends_lists = current_user.all_friends.map { |f| f.lists  }.flatten
    matching_list_records = friends_lists.select { |l| l.item_id == params[:id].to_i }

    #get list entries matching item
    friends_next_list = matching_list_records.select { |l| l.list_type == 'next' }
    friends_watching_list = matching_list_records.select { |l| l.list_type == 'watching' }
    friends_seen_list = matching_list_records.select { |l| l.list_type == 'seen' }

    #convert to array of friend names for easy display on front end
    friends_next = friends_next_list.map { |l| User.find(l.user_id).full_name }
    friends_watching = friends_watching_list.map { |l| User.find(l.user_id).full_name }
    friends_seen = friends_seen_list.map { |l| User.find(l.user_id).full_name }

    render json: { friendsNext: friends_next, friendsWatching: friends_watching, friendsSeen: friends_seen, item_id: params[:id].to_i }
  end
  private

  def item_params
    params.require(:item).permit(:id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :media_type, :genres, :rating)
  end
end
