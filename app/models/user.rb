class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :lists
  has_many :items, through: :lists
  accepts_nested_attributes_for :lists, allow_destroy: true
  has_secure_password
end
