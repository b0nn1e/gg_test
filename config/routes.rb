Rails.application.routes.draw do
  namespace :api do
    resources :campaigns, only: [:create]
    resources :customers, only: [:index, :show]
  end
end
