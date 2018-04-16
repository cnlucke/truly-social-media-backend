class RatingSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :item_id, :rating
end
