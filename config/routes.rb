Greensmoothie::Application.routes.draw do
  root :to => "pages#home"
  devise_for :user, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}

  # core posts
  get '/about-green-smoothies', to: 'posts#show', as: :about, url_name: 'about-green-smoothies'
  get '/green-smoothie-basics', to: 'posts#show', as: :basics, url_name: 'green-smoothie-basics'
  get '/green-smoothie-tools', to: 'posts#show', as: :tools, url_name: 'green-smoothie-tools'

  #pages
  get '/contact', to: 'pages#contact', as: :contact
  get '/terms', to: 'pages#terms', as: :terms
  get '/privacy', to: 'pages#privacy', as: :privacy

  # blog paths
  get '/blog', to: 'posts#index', as: :blog
  get '/blog/:url_name', to: 'posts#show'

  # mailchimp subscribe
  post '/subscribe', to: 'mailchimp#subscribe', as: :subscribe

  resources :citations
  resources :images
  resources :ingredients
  resources :nutrients
  resources :posts
  namespace :unpublished do
    resources :posts, only: :index
  end

  # legacy blog path
  get '/posts/:id/:url_name', to: 'posts#show'

  resources :recipes do
    resources :ratings
  end
  get '/recipes/:id/:title', to: 'recipes#show'
  namespace :support do
    resources :messages, only: :create
  end
  resources :tags
  resources :users
end
