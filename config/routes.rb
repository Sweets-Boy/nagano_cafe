Rails.application.routes.draw do

  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    get 'homes/top'
  end


  namespace :public do
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:index, :new, :show, :create]
    post 'orders/confirm'
    get 'orders/thanks'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    delete 'destroy_all'
    resources :customers, only: [:show, :edit, :update]
    patch 'customers/withdrawal'
    get 'customers/unsubscribe'
    resources :items, only: [:index, :show]
  end

  root to: 'homes#top'
  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  devise_for :users
  post '/search',  to: 'items#search'
  get '/search', to: 'items#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 

end
