class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :parent_id, :content, :created_at, :updated_at
end
