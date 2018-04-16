class ItemsController < ApplicationController
  def rate
    item = current_user.items.find(item_params[:id])
    rating = Rating.find_by(user_id: current_user.id, item_id: item.id)
    if rating
      rating.update(rating: item_params[:rating])
    else
      rating = Rating.create(user_id: current_user.id, item_id: item.id, rating: item_params[:rating])
    end
    # need to return updated item and new rating record
    render json: { item: item, rating: RatingSerializer.new(rating) }
  end

  private

  def item_params
    params.require(:item).permit(:id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :media_type, :genres, :rating)
  end
end
