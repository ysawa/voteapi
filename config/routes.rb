Voteapi::Application.routes.draw do

  resources :votes, only: %i(create index show)

  root "home#index"
end
