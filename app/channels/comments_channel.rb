class CommentsChannel < ApplicationCable::Channel
  def subscribed
    item = Item.find_by(api_id: params[:api_id])
    stream_for item
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
