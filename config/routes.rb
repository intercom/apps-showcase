Rails.application.routes.draw do
  post 'recent_orders/initialize_url'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#index'
end
