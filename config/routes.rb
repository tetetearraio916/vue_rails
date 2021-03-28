Rails.application.routes.draw do

  namespace :api do
    resources :users, only: %i[create]
    resources :sessions, only: %i[create]
  end
end
