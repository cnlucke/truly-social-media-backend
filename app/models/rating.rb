class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :acts, as: :entity, dependent: :destroy
  after_save :update_item_rating

  def update_item_rating
    average_rating = Rating.where(item_id: item_id).average(:rating).to_f.round(1)
    item.update rating: average_rating
  end

  def format_act(act)
    case act.act_type
    when Act::ACT_ITEM_RATED
      "gave #{self.item.title} #{self.rating} stars"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
