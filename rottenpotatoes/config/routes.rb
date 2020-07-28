Rottenpotatoes::Application.routes.draw do
  resources :movies

  get 'search_director/:id', to: 'movies#search_director', as: 'search_director'

  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
