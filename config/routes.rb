Rails.application.routes.draw do

  root 'coins#index'
  resources :users, except: [:index, :destroy]

  resources :following do
    resources :alerts
  end

  resources :sessions, only: [:new, :create]
  delete 'sessions' => 'sessions#destroy', as: 'session'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
