Rails.application.routes.draw do
  resources :patients, only: [ :index, :create, :update, :destroy ] do
    resources :recipes, only: [ :create, :index ]
  end
  post "/create-payment-intent", to: "payments#create_payment_intent"
end
