Rails.application.routes.draw do

  root 'coins#index'

  resources :creators, only: [:index]

  resources :coins, only: [:index, :show]

  resources :users, except: [:index, :destroy]

  resources :following, only: [:index, :update, :destroy] do
    resources :alerts, except: [:index, :new, :show]
    get 'alert_form' => 'alerts#alert_form'
  end

  resources :sessions, only: [:create]
  get 'login' => 'sessions#new', as: :login
  delete 'logout' => 'sessions#destroy', as: :logout
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
