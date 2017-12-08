Rails.application.routes.draw do
  get 'pomodoro/start'

  get 'pomodoro/begin'

  post 'pomodoro/choose_list/:list_id', to: "pomodoro#choose_list", as: 'select_trello_list'

  get 'pomodoro/break_start'

  get 'pomodoro/interrupt'

  get 'pomodoro/finished'

  get 'testpages/finish'

  get 'testpages/during'

  get 'testpages/interrupt'

  get 'testpages/break'

  get 'invitations/create'

  get 'invitations/accept'

  get 'invitations/show'

  get '/about', to: 'welcome#about'

  root 'welcome#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :teams, except: [:index, :destroy] do
    member do
      get 'settings'
      get 'set_trello_board'
    end
  end

  get 'trello/get_boards', as: 'get_trello_boards'
  post 'trello/get_lists', as: 'get_trello_lists'
  post 'trello/get_tasks/:list_id', to: "trello#get_tasks", as: 'get_trello_tasks'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
