class List < ApplicationRecord
  belongs_to :user
  belongs_to :item
  accepts_nested_attributes_for :item
  has_many :acts, as: :entity, dependent: :destroy

  def format_act(act)
    case act.act_type
    when Act::ACT_ITEM_ADDED_TO_LIST
      "#{act.actor.first_name} #{act.actor.last_name} added #{self.item.title} to their #{self.list_type} list"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
