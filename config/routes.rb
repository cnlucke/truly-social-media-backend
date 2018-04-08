Rails.application.routes.draw do
  resources :users
  post "/login", to: "auth#create"
  post "/signup", to: "users#create"
  get "/profile", to: "users#profile"
  post "/add_list_item", to: "lists#create"
end
