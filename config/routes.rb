Labknotes::Application.routes.draw do
  namespace :admin do
    resources :courses do
      get 'export', :on => :member
      resources :students, :only => [:index, :show] do
        resources :reports, :only => [:index, :show, :edit, :update] do
          put 'return', :on => :member
          resources :answers, :only => [] do
            resources :comments, :except => :index
          end
        end
      end
      resources :knotebooks do
        get 'publish', :on => :member
        resources :comments
        resources :reports, :only => [:index]
        resources :knotes
        resources :questions
      end
      resources :enrollments
    end
    root :to => 'home#index'
  end

  resources :courses, :only => [:index, :show] do
    resources :students, :only => [:index, :show] do
      resources :reports do
        resources :answers
      end
    end
    resources :knotebooks, :only => [:index, :show] do
      get 'favorite', :on => :member
    end
    resources :enrollments
  end

  devise_for :users, :students, :professors

  match ':id' => 'home#show', :id => HomeController::VALID_PAGES
    
  root :to => 'home#index'
end
