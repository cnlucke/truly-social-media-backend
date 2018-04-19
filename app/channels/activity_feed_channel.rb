class ActivityFeedChannel < ApplicationCable::Channel
  def subscribed
    act = Act.order('id').first
    stream_for act
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
