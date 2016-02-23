Rails.application.routes.draw do
  root 'docler_containers#index'
  resources :docler_containers

  resources :containers do
    resources :job_queues, shallow: true
  end
  resources :job_templates
end
