class MediaSerializer < ActiveModel::Serializer
  attributes :id, :api_id, :title, :release_date, :poster_url, :backdrop_url, :overview, :genres, :overview
end
