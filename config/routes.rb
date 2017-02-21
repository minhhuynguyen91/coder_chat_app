Rails.application.routes.draw do

  root 'home_pages#index'

  resources :users

  get  'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  delete 'signout' => 'sessions#destroy'

end
