Rails.application.routes.draw do

  resources :questions do
  	resources :answers, only: [:create, :index]	
  end

  resources :answers do
    resources :likes, only: [:create, :destroy]
    member do
      put "accept", to: "answers#accept"
      # put "like", to: "answers#like"
      # delete "unlike", to: "answers#unlike"
    end
  end
  
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" , :registrations => 'registrations'}

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  
  root 'home#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
