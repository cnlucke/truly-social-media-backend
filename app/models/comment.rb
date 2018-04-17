class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :item

  # after_save :create_act

  def format_act(act)
    case act.act_type
    when Act::ACT_COMMENT_CREATED
      "#{actor.first_name} #{actor.last_name} dropped a comment on #{comment.item.title}"
    else
      "Unknown act: #{act.act_type}"
    end
  end

  # def create_act
  #   Act.new
  #   Act.entity_id = self.id
  #   Act.entity_type = self.class.name
  #   Act.actor = self.user
  #   Act.act_type = Act::ACT_COMMENT_CREATED
  #   Act.save
  # end

end
