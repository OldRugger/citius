Rails.application.routes.draw do
  resources :configs

  post "set_active" => 'configs#set_active'

  post "clear_results" => 'results#clear_results'
  get "team_results" => 'results#team_results'

  get "runners" => 'runners#index'

  root :to => 'home#index'

end
