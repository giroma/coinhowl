Rails.application.routes.draw do

  root 'coins#index'

  resources :coins, only: [:index, :show]

  resources :users, except: [:index, :destroy]

  resources :following, only: [:index, :update]do
    resources :alerts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
