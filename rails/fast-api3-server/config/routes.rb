Rails.application.routes.draw do
  resources :order_requests, only: %i(index create)
end
