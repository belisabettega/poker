Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#home'
  resources :hands, only: [:show, :create] do
    resources :cards, only: [:new, :create]
  end
end
