Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "destinations#index"
  resources :destinations

  namespace :api do
    namespace :v1 do
      resources :destinations, only: %i[index show create update destroy]
    end
  end
end
