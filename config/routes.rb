OKZoo::Application.routes.draw do

  root to: "sessions#landing"
  get "/mail", to: "messages#index"
  
  delete "/messages/:id/sent", to: "messages#destroy_sent"
  delete "/messages/:id/recieved", to: "messages#destroy_recieved"
  
resources :messages, only: [:new, :create, :show]
resources :posts, only: [:update]
resource :session
resources :users
end
