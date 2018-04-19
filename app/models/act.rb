class Act < ApplicationRecord
  ACT_COMMENT_CREATED    = 1
  ACT_FRIENDSHIP_CREATED = 2
  ACT_ITEM_ADDED_TO_LIST = 3
  ACT_ITEM_RATED         = 4
  belongs_to :actor, class_name: "User", foreign_key: "actor_id"
  belongs_to :entity, polymorphic: true
  attr_accessor :body

  def self.hash_with_bodies
    all.order(:created_at).reverse.to_a.map do |act|
      act_as_hash = act.serializable_hash
      if act.entity
        act_as_hash["body"] = act.entity.format_act(act)
      else
        act_as_hash["body"] = "Entity does not exist for: #{act}"
      end
      act_as_hash
    end
  end
end
