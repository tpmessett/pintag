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
<<<<<<< HEAD
  resources :tags

    namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :boards, only: [ :show ]
    end
  end
=======
  resources :tags, only: [:edit, :update, :destroy]
  get 'content/:id/tags/new', to: 'tags#new', as: :new_content_tag
  post 'content/:id/tags/create', to: 'tags#create', as: :create_content_tag
>>>>>>> 28f757395397b63fb885d1ec3c1966ff01453134
end
