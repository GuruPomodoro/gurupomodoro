Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  get 'pomodoro/start'
  post 'pomodoro/begin'
  get 'pomodoro/during'
  post 'pomodoro/choose_list/:list_id', to: "pomodoro#choose_list", as: 'select_trello_list'
  post 'pomodoro/break_start/:duration', to: "pomodoro#break_start", as: 'pomodoro_break_start'
  get 'pomodoro/interrupt'
  post 'pomodoro/submit_interrupt'
  post 'pomodoro/interrupt_break'
  get 'pomodoro/finished'

  get '/personalreport', to: 'report#personalreport'
  get '/teamreport', to: 'report#teamreport'

  get 'invitations/create'
  get 'invitations/accept'
  get 'invitations/show'

  get '/about', to: 'welcome#about'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :teams, except: [:index, :destroy] do
    member do
      get 'settings'
      get 'set_trello_board'
    end
  end

  resources :team_invitations, only: [:create, :destroy] do
    member do
      get 'accept'
    end
  end

  resources :team_users, only: [:destroy]

  get 'trello/get_boards', as: 'get_trello_boards'
  post 'trello/get_lists', as: 'get_trello_lists'
  post 'trello/get_tasks/:list_id', to: "trello#get_tasks", as: 'get_trello_tasks'

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
