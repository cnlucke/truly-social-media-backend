class CommentsController < ApplicationController
  def index
    # sort comments by date
    comments = current_user.all_comments.sort_by &:created_at
    render json: comments.map { |c| prepare_comment(c) }
  end

  def create
    item = Item.find_by(api_id: comment_params[:items_attributes][:api_id])
    if !item
      item = Item.create(comment_params[:items_attributes])
    end
    comment = Comment.new(user_id: comment_params[:user_id], item_id: item.id, api_id: item.api_id, parent_id: comment_params[:parent_id], content: comment_params[:content], username: comment_params[:username] )
    if comment.save
      notify Act::ACT_COMMENT_CREATED, comment

      CommentsChannel.broadcast_to(comment.item, {
        type: 'ADD_COMMENT',
        payload: prepare_comment(comment)
        })

      ActivityFeedChannel.broadcast_to(Act.order('id').first, {
        type: 'SET_ACTIVITY',
        payload: current_user.relevant_acts
        })

        render json: { msg: "success", comment: comment }
    else
      render json: {error: comment.errors.full_messages}
    end
  end

  def update
    comment = current_user.comments.find_by(id: comment_params[:id])
    comment.update(comment_params)
    render json: comment
  end

  def destroy
    #code
  end

  def prepare_comment(comment)
    comment_hash = {
      id: comment.id,
      api_id: comment.api_id.to_i,
      item_id: comment.item_id,
      content: comment.content,
      timestamp: comment.created_at,
      username: comment.user.full_name,
      user_id: comment.user.id
    }
  end

  private

  def comment_params
    params.require(:comment).permit(:id, :user_id, :item_id, :api_id, :parent_id, :content, :username, items_attributes: [:id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :genres, :media_type, :position])
  end
end
