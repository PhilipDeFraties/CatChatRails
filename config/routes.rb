Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show], path: '/users'
      post '/register', to: 'users#create'
      post '/auth/login', to: 'authentication#login'
    end
  end
end
