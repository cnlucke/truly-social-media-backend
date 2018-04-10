class CommentsController < ApplicationController
  def create

    @comment = Comment.new(comment_params)
    if @comment
      if current_user.get_list_by_type(list_params[:list_type]).include?(@comment)
        render json: { list_type: list_params[:list_type], comment: @comment }
      else
        # current_user.get_list_by_type(list_params[:list_type]) << @comment
        @list = List.find_or_create_by(user_id: current_user.id, comment_id: @comment.id, list_type: list_params[:list_type])
        # Creates list comment with no list_type populated
        if @list
          render json: { list_type: @list.list_type, comment: @comment }
        else
          render json: {error: 'could not create list'}
        end
      end
    else
      render json: {error: 'could not add comment to db'}
    end
  end

  def update
    @comment = current_user.comments.find_by(id: comment_params[:id])
    @comment.update(rating: comment_params[:rating])
    render json: @comment
  end

  def destroy
    #code
  end
  private

  def comment_params
    params.require(:comment).permit(:id, :user_id, :item_id, :parent_id, :content)
  end
end
