Greensmoothie::Application.routes.draw do
  root :to => "pages#home"
  devise_for :user, controllers: {omniauth_callbacks: "omniauth_callbacks", registrations: "registrations"}

  get '/learn', to: 'pages#learn'
  get '/test', to: 'pages#test'
  get '/terms', to: 'pages#terms', as: :terms
  get '/privacy', to: 'pages#privacy', as: :privacy
  get '/contact', to: 'pages#contact', as: :contact
  post '/subscribe', to: 'mailchimp#subscribe', as: :subscribe
  get '/about-green-smoothies', to: 'posts#show', as: :about, url_name: 'about-green-smoothies'
  get '/green-smoothie-tools', to: 'posts#show', as: :tools, url_name: 'green-smoothie-tools'
  get '/green-smoothie-basics', to: 'posts#show', as: :basics, url_name: 'green-smoothie-basics'

  resources :citations
  resources :images
  resources :ingredients do
    resources :comments
  end
  resources :nutrients do
    get 'add', on: :collection
  end
  resources :posts do
    resources :comments
  end
  get '/blog', to: 'posts#index', as: :blog
  get '/posts/:id/:url_name', to: 'posts#show'
  get '/blog/:url_name', to: 'posts#show'
  resources :recipes do
    resources :comments
    resources :ratings
  end
  get '/recipes/:id/:title', to: 'recipes#show'

  namespace :support do
    resources :messages, only: :create
  end

  resources :tags
  resources :users

end
