class User < ApplicationRecord
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :lists
  has_many :items, through: :lists
  has_many :comments
  has_many :ratings
  has_many :acts, foreign_key: "actor_id"
  has_many :friend_acts, through: :friends, source: :acts
  accepts_nested_attributes_for :lists, allow_destroy: true
  has_secure_password

  def full_name
    self.first_name + ' ' + self.last_name
  end

  def get_list_by_type(type)
    # Get list instances associated with user with correct list type
    list = self.lists.where(list_type: type)
    # Sort list by position, created_at
    sorted_list = list.sort_by {|item| [item.position, item.created_at] }
    # Map list instances to item objects
    sorted_list.map { |list| Item.find(list.item_id)}
  end

  def all_friends
    (self.friends + self.inverse_friends).uniq
  end

  def all_friendships
    self.friendships + self.inverse_friendships
  end

  def find_friendship_by_friend_id(id)
    all_friendships.select { |f| f.friend_id === id || f.user_id === id }
  end

  def all_comments
    # get comments of each friend's friends
    distant_friend_comments = self.all_friends.map do |f|
      f.friend_comments
    end

    (self.comments + self.friend_comments + distant_friend_comments.flatten).uniq
  end

  def friend_comments
    self.all_friends.map { |f| f.comments }.flatten
  end

  def friend_ratings
    self.all_friends.map { |f| f.ratings }.flatten
  end

  def relevant_acts
    acts = all_friends.map { |f| f.acts }.flatten
    acts << self.acts
    (acts.flatten.sort_by &:created_at).reverse
  end

end
