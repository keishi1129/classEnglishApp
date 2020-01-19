Rails.application.routes.draw do
  root "posts#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/word_find', to: 'cardsets#word_find'
  # resources :groups do
  #   collection do
  #     get 'user_list', to: 'groups#before_user_list'
  #     get 'user_create', to: 'groups#before_user_create'
  #   end
  # end
  resources :groups do
    namespace :admin do
      resources :users
    end
  end
  namespace :admin do
    resources :users do
      get '/mypage', to: 'users#mypage'
      get '/word_practice', to: 'users#word_practice'

    end
  end
   
  
  resources :posts do
    post :import, on: :collection
  end

  resources :users, only: :show do
    resources :cardsets do
      get '/practice', to: 'cardsets#practice'
      get '/test', to: 'cardsets#test'

      collection do 
        get '/test_index', to: 'cardsets#test_index'
      end
    end
    resources :tests, only: :show do
      collection do
        get 'word_king'
        get 'success_or_fail'
      end
      
    end
  end
end
