class Act < ApplicationRecord
  ACT_COMMENT_CREATED    = 1
  ACT_FRIENDSHIP_CREATED = 2
  ACT_ITEM_ADDED_TO_LIST = 3
  ACT_ITEM_RATED         = 4
  belongs_to :actor, class_name: "User", foreign_key: "actor_id"
  belongs_to :entity, polymorphic: true

  def as_hash_with_body
    act_as_hash = serializable_hash
    if entity
      act_as_hash["body"] = "#{actor.full_name} #{entity.format_act(self)}"
    else
      act_as_hash["body"] = "Entity does not exist for: #{self}"
    end
    act_as_hash
  end

end
