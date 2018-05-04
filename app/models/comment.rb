class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :acts, as: :entity, dependent: :destroy
  accepts_nested_attributes_for :item

  def format_act(act, current_user = nil)
    case act.act_type
    when Act::ACT_COMMENT_CREATED
      "dropped a comment on #{self.item.title}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
