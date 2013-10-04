Voteapi::Application.routes.draw do

  resources :votes, only: %i(create destroy index new) do
    collection do
      get 'count'
      get 'ranking'
      get 'add', to: 'votes#create'
    end

    member do
      get 'del', to: 'votes#destroy'
    end
  end

  root "home#index"
end
