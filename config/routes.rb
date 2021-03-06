Cordel::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
    get "sign_in",  :to => "devise/sessions#new"
    get "sign_up",  :to => "devise/registrations#new"
    get "sign_out", :to => "devise/sessions#destroy"  
  end

  devise_scope :user do
    get '/users/auth/facebook' => 'users/omniauth_callbacks#passthru'
    get '/users/auth/facebook/callback' => 'users/omniauth_callbacks#passthru'
  end

  resources :books do
    collection do
      get :search
    end
  end
  
  resources :shelves do
    get :put_the_book_on_the_shelf, :path_prefix => '/shelves/:id', :requirements => { :extra => :book_id }, :on => :member
  end
  
  resources :authors
  
  root :to => "home#index"
  
end
