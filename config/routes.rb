Rails.application.routes.draw do

  # resources :friendships do
  #   member do
  #     put :accept
  #   end
  # end
  
  resources :searches

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

  resources :users, only: [:index, :show] do
    member do
      get 'profile_page_users_posts'
      get 'profile_page_users_friends'
      get 'profile_page_users_badges'
      get 'sort_questions_by_newest'
      get 'sort_questions_by_accepted'
      get 'sort_answers_by_newest'
      get 'sort_answers_by_likes'
    end
  end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
    member do
      get 'profile'
    end
  end
  
  root 'home#index'

  get "friendships/request", to: "friendships#request_friendship", as: :friend_request
  get "friendships/accept", to: "friendships#accept_friendship", as: :friend_accept
  delete "friendships/destroy", to: "friendships#destroy_friendship", as: :friend_destroy


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
