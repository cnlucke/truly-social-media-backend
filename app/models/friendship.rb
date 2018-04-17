class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  # after_save :create_act

  def format_act(act)
    case act.act_type
    when Act::ACT_FRIENDSHIP_CREATED
      "#{act.actor.first_name} #{act.actor.last_name} became friends with #{self.friend.first_name} #{self.user.last_name}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
