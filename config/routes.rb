Rails.application.routes.draw do
  devise_for :teachers, controllers: {
    sessions:      'teachers/sessions',
    passwords:     'teachers/passwords',
    registrations: 'teachers/registrations'
  }
  devise_for :students, controllers: {
    sessions:      'students/sessions',
    passwords:     'students/passwords',
    registrations: 'students/registrations'
  }
  root "tests#index"
  get '/word_find', to: 'cardsets#word_find'
  get '/find_words_name', to: 'cardsets#find_words_name'
  get '/find_words_definition', to: 'cardsets#find_words_definition'
  get 'word_king_menu', to: 'tests#word_king_menu'


  resources :teachers, only: [:new, :create, :edit, :update] do
    get '/mypage', to: 'teachers#mypage'
    get '/word_king', to: 'teachers#word_king'
  end

  resources :teachers, only: :show do
    resources :classrooms, shallow: true do
      resources :students
    end
  end

  resources :students, only: :show do
    get '/mypage', to: 'students#mypage'

    resources :cardsets, only: :show do
      member do
        get 'practice', to: 'cardsets#practice'
        get 'test', to: 'cardsets#test'
      end
    # get '/word_practice', to: 'students#word_practice'
    # get '/word_king', to: 'students#word_king'
    end
  end

  resources :cardsets, only: [:index, :new, :create, :edit, :update] 

  resources :teachers, shallow: true do
    resources :cardsets, only: :show do
      # get '/practice', to: 'cardsets#practice'
      # get '/test', to: 'cardsets#test'

      collection do 
        get '/test_index', to: 'cardsets#test_index'
      end
    end
  end
  
  resources :posts do
    post :import, on: :collection
  end

  resources :tests, only: :index do
    collection do
      get 'success_or_fail'
    end
  end
end
