Rails.application.routes.draw do
  
  root                'static_pages#home'
  get    'guide'   => 'static_pages#guide' 
  get    'about'   => 'static_pages#about'
  get    'contact' => 'static_pages#contact'
  get    'policy'  => 'static_pages#policy'
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
  get 'resend_verification'  => 'users#resend_verification'
  post 'resend_verification_email'  => 'users#resend_verification_email'
  
  
  #this sets up a receptor for webhooks with the stripe event gem
  mount StripeEvent::Engine, at: '/stripe/webhook'
  
  resources :users do
      resources :pictures, only: [:create, :update, :destroy]
      resource :subscription
      resource :card
      resources :conversations, controller: "user_conversations" do 
        member do
          put :deletion
        end
        resources :messages 
      end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
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
    resources :categories do 
        resources :documents
    end
   resources :team_matches
   resources :pictures, only: [:create, :update, :destroy]
   resources :statuses, only: [:create, :update]
   resources :events
   resources :topics do
     resources :comments
   end
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
