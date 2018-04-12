class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :lists
  has_many :items, through: :lists
  has_many :comments
  accepts_nested_attributes_for :lists, allow_destroy: true
  has_secure_password

  def get_list_by_type(type)
    # Get list instances associated with user with correct list type
    list = self.lists.where(list_type: type)
    # Sort list by position, created_at
    sorted_list = list.sort_by {|item| [item.position, item.created_at] }
    # Map list instances to item objects
    sorted_list.map { |list| Item.find(list.item_id)}
  end
end
