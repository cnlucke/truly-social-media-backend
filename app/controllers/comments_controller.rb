class CommentsController < ApplicationController
  def index
    render json: current_user.all_comments.map { |c| CommentSerializer.new(c)  }
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      notify Act::ACT_COMMENT_CREATED, comment
      render json: { comment: comment, user: comment.user }
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

  private

  def comment_params
    params.require(:comment).permit(:id, :user_id, :item_id, :parent_id, :content, :timestamp, :api_id, :username)
  end
end
