Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/register',       to: 'users#create'
      post '/auth/login',     to: 'authentication#login'
    end
  end
end
