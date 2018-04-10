class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :lists
  has_many :items, through: :lists
  accepts_nested_attributes_for :lists, allow_destroy: true
  has_secure_password

  def get_list_by_type(type)
    # Get list instances associated with user with correct list type
    list = self.lists.where(list_type: type)
    # Map list instances to item objects
    items = list.map { |list| Item.find(list.item_id)}
    # Sort list by created_at date
    items.sort_by {|item| item.created_at}.reverse
  end
end
