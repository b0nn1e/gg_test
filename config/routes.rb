Rails.application.routes.draw do
  namespace :api do
    resources :campaigns, only: [:create]
    resources :recipients, only: [:index, :show]
  end
end
