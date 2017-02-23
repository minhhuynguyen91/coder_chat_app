Rails.application.routes.draw do

  root 'home_pages#index'

  resources :users do
    collection do
      get 'add_friend'
      get 'remove_friend'
      get 'friends'
    end
  end
    
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
