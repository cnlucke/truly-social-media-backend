class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :item

  after_save :update_item_rating #, :create_act

  def update_item_rating
    average_rating = Rating.where(item_id: item_id).average(:rating).to_f
    item.update rating: average_rating
  end

  def format_act(act)
    case act.act_type
    when Act::ACT_ITEM_RATED
      "#{actor.first_name} #{actor.last_name} gave #{self.item.title} #{self.rating} stars"
    else
      "Unknown act: #{act.act_type}"
    end
  end

  # def create_act
  #   Act.new
  #   Act.entity_id = self.id
  #   Act.entity_type = self.class.name
  #   Act.actor = self.user
  #   Act.act_type = Act::ACT_ITEM_RATED
  #   Act.save
  # end
end
