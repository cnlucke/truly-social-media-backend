class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  # after_save :create_act

  def format_act(act)
    case act.act_type
    when Act::ACT_FRIENDSHIP_CREATED
      "#{actor.first_name} #{actor.last_name} became friends with #{self.friend.first_name} #{self.user.last_name}"
    else
      "Unknown act: #{act.act_type}"
    end
  end

  # def create_act
  #   binding.pry
  #   Act.new
  #   Act.actor = self.user
  #   Act.act_type = Act::ACT_FRIENDSHIP_CREATED
  #   Act.entity_id = self.id
  #   Act.entity_type = self.class.name
  #   Act.save
  # end

end
