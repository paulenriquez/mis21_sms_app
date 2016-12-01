Rails.application.routes.draw do
  root to: 'pages#index'

  # Custom Inbox Routes
  post 'inbox/receive', to: 'inboxes#receive'
  get 'inbox/forward/:id', to: 'inboxes#forward', as: 'forward_inbox'
  post 'inbox/forward', to: 'inboxes#create_in_outbox'
  
  # Custom Outbox Routes
  get 'outbox/resend/:id', to: 'outboxes#resend', as: 'resend_outbox'
  get 'outbox/:id/success', to: 'outboxes#sent', as: 'sent_outbox'

  devise_for :users
  resources :outboxes, path: 'outbox', except: [:destroy]
  resources :inboxes, path: 'inbox', except: [:new, :create, :edit, :update]
  resources :pages
end