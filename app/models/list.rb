class List < ApplicationRecord
  belongs_to :user
  belongs_to :item
  accepts_nested_attributes_for :item

  # after_save :create_act

  def format_act(act)
    case act.act_type
    when Act::ACT_ITEM_ADDED_TO_LIST
      "#{actor.first_name} #{actor.last_name} added #{self.item.title} to their #{self.list_type} list"
    else
      "Unknown act: #{act.act_type}"
    end
  end

  # def create_act
  #   Act.new
  #   Act.entity_id = self.id
  #   Act.entity_type = self.class.name
  #   Act.actor = self.user
  #   Act.act_type = Act::ACT_ITEM_ADDED_TO_LIST
  #   Act.save
  # end
end
