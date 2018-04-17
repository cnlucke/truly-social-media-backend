class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def format_act(act)
    case act.act_type
    when Act::ACT_COMMENT_CREATED
      "#{act.actor.first_name} #{act.actor.last_name} dropped a comment on #{self.item.title}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
