Rails.application.routes.draw do
  post 'identity_verification/initialize_url'
  post 'identity_verification/submit_url'
  post 'recent_orders/initialize_url'
  post 'recent_orders/submit_url'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
