class Item < ApplicationRecord
  has_many :lists
  has_many :users, through: :lists
  has_many :comments
end
