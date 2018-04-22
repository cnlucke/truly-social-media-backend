class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"
  has_many :acts, as: :entity, dependent: :destroy

  def format_act(act)
    case act.act_type
    when Act::ACT_FRIENDSHIP_CREATED
      "became friends with #{self.friend.first_name} #{self.friend.last_name}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end
