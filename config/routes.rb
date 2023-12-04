Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: 'home#index'

  get 'documents', to: 'documents#index'
  post 'documents', to: 'documents#create'
  put 'documents', to: 'documents#update'
  delete 'documents', to: 'documents#destroy'
end
