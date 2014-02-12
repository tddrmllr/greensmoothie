Greensmoothie::Application.routes.draw do
  root :to => "pages#home"
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :user, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}

  get '/about', to: 'pages#about'

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
