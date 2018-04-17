class ActsController < ApplicationController
  def feed
    @acts_with_bodies = @acts.map { |act|
      if act.entity
        act.body = act.entity.format_act(act.act_type)
      else
        act.body = "Entity does not exist for: #{act}"
      end

      act
    }
    render json: @acts_with_bodies
  end
end
