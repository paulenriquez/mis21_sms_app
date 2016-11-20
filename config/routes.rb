Rails.application.routes.draw do
  root to: 'pages#index'
  
  resources :outboxes, path: 'outbox'
  resources :inboxes, path: 'inbox'
end