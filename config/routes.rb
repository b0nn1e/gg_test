Rails.application.routes.draw do
  namespace :api do
    resources :campaigns, only: [:create]
  end
end
