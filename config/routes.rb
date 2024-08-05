Rails.application.routes.draw do
  devise_for :users

  root "home#index"
  get 'home/index', to: 'home#index'
end
