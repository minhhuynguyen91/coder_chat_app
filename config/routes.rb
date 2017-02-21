Rails.application.routes.draw do

  root 'home_pages#index'

  resources :users
  resources :messages do
    collection do 
      get 'incoming'
      get 'sent'
    end
  end

  get  'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  delete 'signout' => 'sessions#destroy'

end
