OKZoo::Application.routes.draw do
  root to: "sessions#landing"

resource :session
resources :users
end
