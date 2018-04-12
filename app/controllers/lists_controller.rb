class ListsController < ApplicationController
  def index
    render json: current_user.lists
  end

  def create
    @item = Item.find_by(api_id: list_params[:items_attributes][:api_id])
    if !@item
      @item = Item.create(list_params[:items_attributes])
    end

    if @item
      if current_user.get_list_by_type(list_params[:list_type]).include?(@item)
        render json: { list_type: list_params[:list_type], item: @item }
      else
        # current_user.get_list_by_type(list_params[:list_type]) << @item
        @list = List.find_or_create_by(user_id: current_user.id, item_id: @item.id, list_type: list_params[:list_type])
        # Creates list item with no list_type populated
        if @list
          render json: { list_type: @list.list_type, item: @item }
        else
          render json: {error: 'could not create list'}
        end
      end
    else
      render json: {error: 'could not add item to db'}
    end
  end

  def order
    item_objects = list_params[:items_attributes]
    # convert to List objects so that I can update position
    list_objects = item_objects.map { |list_item| List.find_by(user_id: current_user[:id], item_id: list_item[:id]) }
    # #update position field on each item
    list_objects.each_with_index do |item, index|
      item[:position] = index
      item.save
    end
    # convert to list of actual Item objects via Item.find(@items[0].id)
    converted_items = list_objects.map { |list_item| Item.find_by(id: list_item[:item_id]) }
    # render JSON entire list
    render json: converted_items
  end

  def destroy
    list = List.find_by(user_id: current_user.id, item_id: list_params[:item_id], list_type: list_params[:list_type])
    if list.destroy
      render json: { list_type: list.list_type, item: Item.find(list.item_id) }
    else
      render json: { error: "could not remove item from list" }
    end
  end

  private

  # params.require(:person).permit(:name, :age, pets_attributes: [:id, :name, :category])

  def list_params
    params.require(:list).permit(:list_type, :item_id, items_attributes: [:id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :genres, :media_type, :position])
  end
end
