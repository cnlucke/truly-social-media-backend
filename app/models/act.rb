class Act < ApplicationRecord
  ACT_COMMENT_CREATED    = 1
  ACT_FRIENDSHIP_CREATED = 2
  ACT_ITEM_ADDED_TO_LIST = 3
  ACT_ITEM_RATED         = 4
  belongs_to :actor, class_name: "User", foreign_key: "actor_id"
  belongs_to :entity, polymorphic: true
  attr_accessor :body

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
