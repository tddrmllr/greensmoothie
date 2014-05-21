Greensmoothie::Application.routes.draw do
  root :to => "pages#home"
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :user, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}

  get '/learn', to: 'pages#learn'
  get '/test', to: 'pages#test'
  get '/terms', to: 'pages#terms', as: :terms
  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/contact', to: 'pages#contact', as: :contact
  post '/subscribe', to: 'mailchimp#subscribe', as: :subscribe
  post '/support', to: 'pages#support', as: :support
  get '/about-green-smoothies', to: 'posts#core_content', as: :about
  get '/green-smoothie-tools', to: 'posts#core_content', as: :tools
  get '/green-smoothie-basics', to: 'posts#core_content', as: :basics

  resources :citations
  resources :images
  resources :ingredients
  resources :nutrients do
    get 'add', on: :collection
  end
  resources :posts do
    resources :comments
  end
  get '/blog', to: 'posts#index', as: :blog
  get '/posts/:id/:title', to: 'posts#show'
  resources :recipes do
    resources :comments
    resources :ratings
  end
  get '/recipes/:id/:title', to: 'recipes#show'
  resources :tags
  resources :users

end
