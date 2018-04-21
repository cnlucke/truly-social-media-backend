class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :parent_id, :content, :username, :created_at
end
