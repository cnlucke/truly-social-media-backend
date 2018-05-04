class List < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :acts, as: :entity, dependent: :destroy
  accepts_nested_attributes_for :item

  def format_act(act)
    case act.act_type
    when Act::ACT_ITEM_ADDED_TO_LIST
      "added #{self.item.title} to their #{self.list_type} list"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
