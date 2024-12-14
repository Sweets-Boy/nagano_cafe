Rails.application.routes.draw do


  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  
  post '/search',  to: 'items#search'
  get  '/search',  to: 'items#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html


end
