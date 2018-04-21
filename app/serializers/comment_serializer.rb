class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :parent_id, :content, :api_id, :username, :created_at
end
