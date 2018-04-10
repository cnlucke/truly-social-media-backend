class ItemsController < ApplicationController
  def update
    @item = current_user.items.find_by(id: item_params[:id])
    @item.update(rating: item_params[:rating])
    render json: @item
  end

  private

  def item_params
    params.require(:item).permit(:id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :media_type, :genres, :rating)
  end
end
