Rails.application.routes.draw do
  resources :configs

  post "set_active" => 'configs#set_active'

  get "runners" => 'runners#index'

  root :to => 'home#index'

end
