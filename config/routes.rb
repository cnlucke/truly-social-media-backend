Rails.application.routes.draw do
  post "/login", to: "auth#create"
  post "/signup", to: "users#create"
  patch "/profile", to: "users#update"
  get "/profile", to: "users#profile"
  get "/profile/:id", to: "users#friend_profile"
  get "/users", to: "users#index"
  post "/add_list_item", to: "lists#create"
  post "/remove_list_item", to: "lists#destroy"
  patch "/order", to: "lists#order"
  patch "/rate_item", to: "items#update"
  post "/comments", to: "comments#create"
  get "/comments", to: "comments#index"
  get "/friends", to: "friendships#friends"
  post "/friends", to: "friendships#create"
  post "/remove_friend", to: "friendships#destroy"
end
