class CommentsController < ApplicationController
  def index
    # sort comments by date
    comments = current_user.all_comments.sort_by &:created_at
    render json: comments.map { |c| prepare_comment(c) }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      notify Act::ACT_COMMENT_CREATED, comment

      CommentsChannel.broadcast_to(comment.item, {
        type: 'ADD_COMMENT',
        payload: prepare_comment(comment)
        })

      ActivityFeedChannel.broadcast_to(Act.order('id').first, {
        type: 'SET_ACTIVITY',
        payload: Act.hash_with_bodies
        })

        render json: { msg: "success" }
      else
        render json: {error: 'could not add comment to db'}
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
  			item_id: comment.item_id,
  			content: comment.content,
        timestamp: comment.created_at,
        username: comment.user.full_name,
        user_id: comment.user.id
  		}
  	end

    private

    def comment_params
      params.require(:comment).permit(:id, :user_id, :item_id, :parent_id, :content, :username)
    end
  end
