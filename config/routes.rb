Rails.application.routes.draw do


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}



  namespace :admin do
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :genres, only: [:index, :edit, :create, :update]
    resources :items, only: [:index, :new, :show, :edit, :create, :update]
    get 'homes/top'
  end



  resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  resources :orders, only: [:index, :new, :show, :create] do
    collection do
      post 'confirm'
      get 'thanks'
    end
  end
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    collection do
      delete 'destroy_all'
    end
  end
  resources :customers, only: [:show, :edit, :update]
  patch 'customers/withdrawal'
  get 'customers/unsubscribe'
  resources :items, only: [:index, :show]


  root to: 'homes#top'
  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  
  post '/search',  to: 'items#search'
  get '/search', to: 'items#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
