class ItemSerializer < ActiveModel::Serializer
  attributes :id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :media_type, :genres, :rating, :created_at
end
