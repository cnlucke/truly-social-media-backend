class ListsController < ApplicationController
  def index
    render json: current_user.lists
  end

  def create

    @item = Item.find_or_create_by(list_params[:items_attributes])
    current_user.items << @item
    @list = current_user.lists.last
    @list.list_type = list_params["list_type"]
    if @list.save
      render json: { "list_type": @list.list_type, item: @item }
    else
      render json: {error: 'could not create list'}
    end
  end

  private

  # params.require(:person).permit(:name, :age, pets_attributes: [:id, :name, :category])

  def list_params
    params.require(:list).permit(:list_type, items_attributes: [:api_id, :title, :date, :poster_url, :backdrop_url, :overview, :genres])
  end
end
