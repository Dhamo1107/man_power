Rails.application.routes.draw do
  get 'professions/search'
  devise_for :users

  root 'users#index'

  resources :users, only: [:index, :show]

  resources :professions do
    collection do
      get :search
    end
  end

end
