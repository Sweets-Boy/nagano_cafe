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
    get '/' => 'homes#top'

    resources :customers, only: [:show] do
      resources :orders, only: [:index]
    end
  end


  scope module: :public do
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
    resources :customers, only: [:show, :edit, :update] do
    patch 'customers/withdrawal'
    get 'customers/unsubscribe'
  end
    get 'customers/my_page', to: 'customers#show', as: :customers_my_page
    patch 'information', to: 'customers#update', as: :costomers_information_update
    get 'customers/information/edit', to: 'customers#edit', as: :customers_information_edit
    resources :items, only: [:index, :show]
  end

  root to: 'homes#top'
  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  
  get 'keyword/search', to: 'searches#keyword_search', as: 'keyword_search'
  get 'genre/search', to: 'searches#genre_search', as: 'genre_search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
