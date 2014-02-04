Greensmoothie::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}

  root :to => "pages#home"

  resources :citations
  resources :images
  resources :ingredients
  resources :nutrients do
    get 'add', on: :collection
  end
  resources :posts do
    resources :comments
  end
  get '/posts/:id/:title', to: 'posts#show'
  resources :recipes do
    resources :comments
  end
  get '/recipes/:id/:title', to: 'recipes#show'
  resources :tags
  resources :users

end
