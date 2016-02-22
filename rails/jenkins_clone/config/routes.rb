Rails.application.routes.draw do
  root 'docler_containers#index'
  resources :docler_containers
end
