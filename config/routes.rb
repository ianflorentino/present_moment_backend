Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      # Users
      get :me, to: 'users#show'
      put :users, to: 'users#update'
      resources :users, only: [:index, :create]
    end
  end
end
