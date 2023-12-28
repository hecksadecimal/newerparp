Rails.application.routes.draw do
  resources :announcements, only: [:index, :show]
  get 'redeem', to: 'redeem#index'
  put 'redeem/consume'

  get 'uploader/image'
  namespace :admin do
      resources :accounts
      resources :admin_tiers, except: :index
      resources :admin_tier_permissions, except: :index
      resources :beta_codes
      resources :chats, except: :index
      resources :chat_users
      resources :group_chats, except: :index
      resources :legacy_users, except: :index
      resources :messages, except: :index
      resources :announcements

      root to: "accounts#index"
    end
  resources :messages, except: [:index]

  resources :chat, only: :show, controller: "chats" do
    member do
      get 'log'
      patch 'presence'
    end
  end
  resources :chats, except: :show do
    collection do
      get 'subscribed'
      get 'visited'
      get 'searched'
      get 'owned'
    end
  end

  devise_for :accounts

  post 'uploader/image'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "announcements#index"
end
