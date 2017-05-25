Rails.application.routes.draw do
  resources :replies, except: [:update]
  resources :rivs, except: [:update]
  resources :users

  # custom
  post 'follows/:follower_id/:followed_id', to: "follows#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
