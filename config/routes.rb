root "sessions#home"
 
 #users route
  get '/users/most-active' => 'users#most_active'
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
 
  #login route
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
 
  #logout route
  delete '/logout' => 'sessions#destroy'

  #omniauth callback route

  get '/auth/google_oauth2/callback' => 'sessions#google'
  # get '/auth/:provider/callback', => 'sessions#google'

  resources :posts do
     resources :comments
   end
   resources :comments
   resources :users do
     resources :posts, shallow: true
   end

   resources :categories, only: [:index, :show]
   
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 end