Rails.application.routes.draw do
  resources :questions do
  	resources :answers, only: [:create, :index]	
  end
  devise_for :admins
  devise_for :users
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
