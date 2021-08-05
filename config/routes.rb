Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'
  post 'beers/:id/mark_favorite', to: 'beers#mark_favorite'

  get 'beers/get_all', to: 'beers#get_all'
  get 'beers/my_favorites', to: 'beers#my_favorites'

  resources :beers
end
