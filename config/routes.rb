Rails.application.routes.draw do
  root "posts#index"
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/login_for_teacher', to: 'sessions#teacher_new'
  post '/login_for_teacher', to: 'sessions#teacher_create'
  delete '/logout', to: 'sessions#destroy'
  get '/word_find', to: 'cardsets#word_find'
  get '/find_words_name', to: 'cardsets#find_words_name'
  get '/find_words_definition', to: 'cardsets#find_words_definition'
  get 'word_king_menu', to: 'tests#word_king_menu'
  # resources :groups do
  #   collection do
  #     get 'user_list', to: 'groups#before_user_list'
  #     get 'user_create', to: 'groups#before_user_create'
  #   end
  # end

  resources :teachers, only: [:new, :create, :edit, :update] do
    get '/mypage', to: 'teachers#mypage'
    get '/word_king', to: 'teachers#word_king'
  end

  resources :classrooms do
    resources :students
  end

  resources :students, only: :show do
    get '/mypage', to: 'students#mypage'
    get '/word_practice', to: 'students#word_practice'
    get '/word_king', to: 'students#word_king'

    resources :cardsets do
      get '/practice', to: 'cardsets#practice'
      get '/test', to: 'cardsets#test'

      collection do 
        get '/test_index', to: 'cardsets#test_index'
      end
    end
  end
  
  resources :posts do
    post :import, on: :collection
  end

  resources :tests, only: :show do
    collection do
      get 'success_or_fail'
    end
  end
end
