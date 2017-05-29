Rails.application.routes.draw do
  resources :likes, except: [:update]
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
  get ':username', to: "users#find_by_username"
  delete 'follows/:follow_id', to: "follows#destroy"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
