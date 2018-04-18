class ActsController < ApplicationController
  def feed
    hash_with_bodies = Act.all.order(:created_at).reverse.to_a.map do |act|
      act_as_hash = act.serializable_hash
      if act.entity
        act_as_hash["body"] = act.entity.format_act(act)
      else
        binding.pry
        act_as_hash["body"] = "Entity does not exist for: #{act}"
      end
      act_as_hash
    end

    render json: hash_with_bodies
  end
end
