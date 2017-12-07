Rails.application.routes.draw do
  get 'pomodoro/start'

  get 'pomodoro/begin'

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

  resources :teams


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
