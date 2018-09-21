Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
