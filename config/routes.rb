Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards do
    post :send_to_slack
    resources :contents, only: [:index, :show, :new, :create]
    member do
      post :share
    end
  end

  resources :contents, only: [:destroy, :edit, :update] do
    post :send_content_to_slack
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :boards, only: [ :show, :index ] do
          resources :contents, only: [ :create ]
      end
      resources :contents, only: [ :show ]
      resources :tags, only: [ :index ]
    end
  end

  resources :tags, only: [:edit, :update, :destroy]
  get 'content/:id/tags/new', to: 'tags#new', as: :new_content_tag
  post 'content/:id/tags/create', to: 'tags#create', as: :create_content_tag
  get '/credits', to: 'pages#credits'
end
