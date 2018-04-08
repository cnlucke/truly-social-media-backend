class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :city, :state
end

# id: @user.id, email: @user.email, first_name: @user.first_name, last_name: @user.last_name, city: @user.city, state: @user.state
