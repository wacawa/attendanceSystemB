Rails.application.routes.draw do
  root 'static_pages#top'
    
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'edit_basic_info', to: 'users#edit_basic_info'
  patch 'update_basic_info', to: 'users#update_basic_info'

  resources :users do
    get 'attendances/edit', to: 'attendances#edit'
    resources :attendances, only: :update
  end

end

