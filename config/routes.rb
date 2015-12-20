Rails.application.routes.draw do

  resources :questions
  resources :posts
  resources :advertisements
  get "about" => "welcome#about"
  get "contact" => "welcome#contact"
  root to: 'welcome#index'

end
