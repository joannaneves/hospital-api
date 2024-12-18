Rails.application.routes.draw do
  resources :patients, only: [ :index, :create, :update, :destroy ] do
    resources :recipes, only: [ :create, :index ]  # Permite criar e listar receitas dentro de um paciente
  end
end
