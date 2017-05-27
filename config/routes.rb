Rails.application.routes.draw do
  resources :likes
  resources :replies, except: [:update]
  resources :rivs, except: [:update]
  resources :users do
    collection do
      post '/login', to: 'users#login'
    end
  end

  # custom
  post 'follows', to: "follows#create"
  get 'users/logged/:user_id', to: "users#current_user"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
