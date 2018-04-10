class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :parent_id, :content, :timestamp, :api_id, :username
end
