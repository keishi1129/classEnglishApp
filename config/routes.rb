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

  resources :teachers, only: [:new, :create, :edit, :update] do
    get '/mypage', to: 'teachers#mypage'
    get '/word_king', to: 'teachers#word_king'

    resources :classrooms, shallow: true do
      resources :students do
        get '/mypage', to: 'students#mypage'
      end
    end
  end

  resources :teachers, only: :show do
    resources :cardsets, only: :show do
      collection do 
        get '/test_index', to: 'cardsets#test_index'
        get '/word_king_menu', to: 'cardsets#word_king_menu'
      end
    end
  end
  resources :students do
    resources :cardsets, only: :show do
      member do
        get 'practice', to: 'cardsets#practice'
        get 'test', to: 'cardsets#test'
        get 'word_score', to: 'cardsets#word_score'
      end
    end
  end
  resources :cardsets 
  get '/word_find', to: 'cardsets#word_find'
  get '/find_words_name', to: 'cardsets#find_words_name'
  get '/find_words_definition', to: 'cardsets#find_words_definition'

  resources :posts do
    post :import, on: :collection
  end

  resources :test, only: :index


end
