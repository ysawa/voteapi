Voteapi::Application.routes.draw do

  resources :votes, only: %i(create index) do
    collection do
      get 'count'
      get 'ranking'
    end
  end

  root "home#index"
end
