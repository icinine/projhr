Rails.application.routes.draw do
  
  resources :vacations do
	  collection { post :import }
  end

  #resources :vacations
  
  #resources :employees
  
 
  
  resources :employees do
     resources :vacations
  end
  
  resources :depts

  resources :profiles

  devise_for :users
  
  get 'welcome/index'

  get 'welcome/about'

  get 'welcome/contact'

  root to: 'welcome#index'
  
  get '/signedinuserprofile' => 'profiles#signedinuserprofile'
  
  match '/contacts',     to: 'contacts#new', via: 'get'
resources "contacts", only: [:new, :create]

  get 'contacts/contact'
end
