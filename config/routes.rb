Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :boards do
    resources :contents, only: [:index, :show, :new, :create]
  end
  resources :content, only: [:destroy, :edit, :update]
  resources :tags
end
