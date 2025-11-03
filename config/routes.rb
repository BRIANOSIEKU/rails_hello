namespace :api do
  namespace :v1 do
    resources :users
    resources :facts do
      member do
        post 'like'
      end
    end
  end
end
