OKZoo::Application.routes.draw do
  root to: "sessions#landing"

resources :posts, only: [:update]
resource :session
resources :users
end
