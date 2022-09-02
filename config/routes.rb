Rails.application.routes.draw do
  resources :configs

  post "set_active" => 'configs#set_active'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
