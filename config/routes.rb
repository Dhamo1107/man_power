Rails.application.routes.draw do

  devise_for :users

  root 'users#index'

  resources :users, only: [:index, :show] do
    collection do
      get :search
    end
  end

  resources :professions do
    collection do
      get :search
    end
  end

  resources :tasks do
    member do
      patch :update_status
    end
  end

end
