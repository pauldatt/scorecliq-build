Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'help'    => 'static_pages#help' 
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get    'home'    => 'static_pages#home'
  get    'search'  => 'search#index', as: :search
  get    'team'    => 'scoreboards#teams'
  put  'private'   => 'privates#privatize'
  put  'unprivate' => 'privates#unprivatize'
  post   'request_to_join'        => 'requests#create'
  put  'request_to_join_accept'   => 'requests#accept'
  delete 'request_to_join_delete' => 'requests#delete'
  put   'assign_captain'          => 'team_members#assign'
  put  'unassign_captain'         => 'team_members#unassign'
  post 'assign_manager'           => 'managers#create'
  delete 'unassign_manager'       => 'managers#delete'
  
  resources :users do
      resources :pictures, only: [:create, :update, :destroy]
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
     post :reply
     post :restore
     post :mark_as_read
    end
    collection do
       delete :empty_trash
    end
  end
  resources :messages, only: [:new, :create]
  resources :scoreboards do 
    member do
      post   :favourite
      delete :favourite
      delete :deleteteams
      get    :followers
      get    :admins
      delete :deletematches
      delete :deleteevents
    end
    resources :teams do 
       resources :team_members do 
           member do
               post :add 
           end
       end
       member do
           patch :update_name
       end
    end
    resources :comments
    resources :categories do 
        resources :documents
    end
   resources :team_matches
   resources :pictures, only: [:create, :update, :destroy]
   resources :statuses, only: [:create, :update]
   resources :events
   resources :topics
  end
  
  resources :invitations, only: [:new, :create]
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'static_pages#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  
end
