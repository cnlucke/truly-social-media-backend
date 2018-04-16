class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  after_save :update_item_rating

  def update_item_rating
    average_rating = Rating.where(item_id: item_id).average(:rating).to_f
    item.update rating: average_rating
  end
end
