Greensmoothie::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  root :to => "pages#home"

  resources :images
  resources :ingredients
  resources :nutrients
  resources :recipes
  resources :users

end
