Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "facts/index"
      get "facts/show"
      get "facts/create"
      get "facts/update"
      get "facts/destroy"
      get "users/index"
      get "users/show"
      get "users/create"
      get "users/update"
      get "users/destroy"
    end
  end
  get "home/index"
  root "home#index"
end
