Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do
      resources :activities, only: [:index]
    end
  end

  get '/api/v1/user', to: 'api/v1/users#show'
  patch '/api/v1/user', to: 'api/v1/users#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
