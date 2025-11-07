Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :facts do
        # Custom route for liking a fact
        member do
          post :like
        end
      end
    end
  end
end
