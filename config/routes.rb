Greensmoothie::Application.routes.draw do
  devise_for :users
  root :to => "pages#home"

  resources :recipes
  resources :ingredients
  resources :nutrients
  resources :users
end
