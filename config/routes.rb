Rails.application.routes.draw do
  resources :configs

  post 'set_active' => 'configs#set_active'
  post 'clear_results' => 'results#clear_results'

  get 'team_results' => 'results#team_results'
  get 'awt' => 'results#awt'

  get 'runners' => 'runners#index'

  get 'teams' => 'teams#index'

  get 'teams/:id' => 'teams#show'

  get "awards" => "awards#index"

  root :to => 'home#index'

end
