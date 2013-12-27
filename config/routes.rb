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
  resources :recipes
  resources :users

end
