Rails.application.routes.draw do
  resources :patients, only: [:index, :create, :update, :destroy]
end
