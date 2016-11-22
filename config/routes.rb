Rails.application.routes.draw do
  root to: 'pages#index'
  
  post '/inbox/receive', to: 'inboxes#receive'

  resources :outboxes, path: 'outbox', except: [:edit, :update, :destroy]
  resources :inboxes, path: 'inbox', except: [:new, :create]
end