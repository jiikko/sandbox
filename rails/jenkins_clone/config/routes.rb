Rails.application.routes.draw do
  root 'containers#index'

  resources :containers do
    resources :queued_jobs, shallow: true
    member do
      post :execute
    end
  end
  resources :template_jobs
end
