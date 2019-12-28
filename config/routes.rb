Rails.application.routes.draw do
  resources :locks do
    resources :records
    resources :rfids
    resources :passcodes
    resources :keys
  end

  resources :sessions
  resources :users

  root to: 'locks#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
