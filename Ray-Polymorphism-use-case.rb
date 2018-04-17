@acts_with_bodies = @acts.map { |act|
  if act.entity
    act.body = act.entity.format_act(act.act_type)
  else
    act.body = "WE DON'T KNOW!!!"
  end

  act
}

@acts = [Act, Act]
@ad


Act.with_bodies
Act.where(....).with_bodies

class Act
  # ...
  ACT_COMMENT_CREATED = 1
  attr_accessor :body
  # ...
  
  def self.with_bodies
    all.map do |act|
      if act.entity
        act.body = act.entity.format_act(act)
      else
        act.body = "WE DON'T KNOW!!!"
      end

      act
    end
  end
end

class Comment
  def format_act(act)
    case act.act_type
    when Act::ACT_COMMENT_CREATED
      "#{actor.name} dropped a comment on #{comment.movie.name}"
    else
      "Unknown act: #{act.act_type}"
    end
  end
end



# Act columns:
#
# actor_id:integer
# act_type:integer
# entity_id:integer
# entity_type:string
#
# entity_type: string representing model type 
# entity_id: id of record(model instance) 
# actor_id: id of associated user 
# act_type: integer of act constant defined in Act
# you’ll have belongs_to :actor, class_name: "User", foreign_key: "actor_id"

# class User
#   has_many :acts, foreign_key: "actor_id"
#   has_many :friend_acts, through: :friends, source: :acts
# end

class Act < ApplicationRecord
  belongs_to :actor, class_name: "User", foreign_key: "actor_id"
  belongs_to :entity, polymorphic: true
end
