Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#index'
  
  post '/inbox/receive', to: 'inboxes#receive'

  resources :outboxes, path: 'outbox', except: [:destroy]
  resources :inboxes, path: 'inbox'
  resources :pages
end