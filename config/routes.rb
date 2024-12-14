Rails.application.routes.draw do
  get '/homes/top' => 'homes#top', as: 'top'
  get '/homes/about' => 'homes#about', as: 'about'
  devise_for :users
  post '/search',  to: 'items#search'
  get '/search', to: 'items#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 

end
