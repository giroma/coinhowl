Rails.application.routes.draw do

  root 'coins#index'

  resources :coins, only: [:index, :show]

  resources :users, except: [:index, :destroy]

  resources :following, only: [:index, :update, :destroy] do
    resources :alerts, except: [:index, :new, :show]
  end

  resources :sessions, only: [:new, :create]
  delete 'sessions' => 'sessions#destroy', as: 'session'
  get 'testalert' => 'alerts#test_email_alert'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
