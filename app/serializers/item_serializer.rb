class ItemSerializer < ActiveModel::Serializer
  attributes :id, :api_id, :title, :date, :poster_url, :backdrop_url, :overview, :media_type, :genres, :rating, :created_at
end

# media_type is a field that comes from the api. Usuallly something like "movie"
