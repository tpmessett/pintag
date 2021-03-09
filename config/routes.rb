Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards do
    resources :contents, only: [:index, :show, :new, :create]
    member do
      post :share
    end
  end
  resources :contents, only: [:destroy, :edit, :update]
  resources :tags

    namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :boards, only: [ :show ]
    end
  end
end
