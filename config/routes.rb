Rails.application.routes.draw do
  resources :users
  post "/login", to: "auth#create"
  post "/signup", to: "users#create"
  get "/profile", to: "users#profile"
  post "/add_list_item", to: "lists#create"
  post "/remove_list_item", to: "lists#destroy"
  patch "/rate_item", to: "items#update"
end
