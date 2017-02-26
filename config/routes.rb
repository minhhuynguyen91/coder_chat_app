Rails.application.routes.draw do
  root 'home_pages#index'

  resources :users do
    collection do
      get 'friends'
    end
  end
  
  resources :friendships, :only => [:index, :create]
  delete 'friendships' => 'friendships#destroy'

  resources :blocklists, :only => [:index, :create]
  delete 'blocklists' => 'blocklists#destroy'

  resources :messages do
    collection do 
      get 'incoming'
      get 'sent'
      get 'new_group' => 'messages#new_group'
      post 'new_group' => 'messages#create_group'
    end
  end

  get  'signin' => 'sessions#new'
  post 'signin' => 'sessions#create'

  delete 'signout' => 'sessions#destroy'

  get 'auth/:provider/callback' => 'sessions#callback'

end
