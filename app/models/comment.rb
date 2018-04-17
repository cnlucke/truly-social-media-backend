class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  def format_act(act)
    case act.act_type
    when Act::ACT_COMMENT_CREATED
      "#{actor.first_name} #{actor.last_name} dropped a comment on #{comment.item.title}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
