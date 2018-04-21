class ActsController < ApplicationController
  def feed

    ActivityFeedChannel.broadcast_to(Act.order('id').first, {
      type: 'SET_ACTIVITY',
      payload: current_user.relevant_acts
      })

    render json: { msg: "success" }
  end
end
