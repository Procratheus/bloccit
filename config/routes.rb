Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  resources :topics do
    resources :posts, except: [:index] do
    end
  end
  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up_vote' => 'votes#up_vote', as: :up_vote
    post '/down_vote' => 'votes#down_vote', as: :down_vote
  end
  resources :questions
  resources :advertisements
  get "about" => "welcome#about"
  get "contact" => "welcome#contact"
  root to: 'welcome#index'

end
