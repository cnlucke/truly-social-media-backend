class ListSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :media_id, :list_type
end
