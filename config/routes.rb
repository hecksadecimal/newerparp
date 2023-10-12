Rails.application.routes.draw do
  resources :messages
  resources :beta_codes

  resources :chat, only: :show, controller: "chats" do
    member do
      get 'log'
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
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "home#index"
end
