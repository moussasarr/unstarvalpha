Rails.application.routes.draw do
  get 'groupchatcomments/new'

  get 'groupchatcomments/create'

  get 'activities/index'

  root 'home#home' 
  
  get 'groups/new'

  get 'groups/create'

  get 'groups/show'

  get 'groups/edit'

  get 'groups/update'

  get 'groups/destroy'
  get 'groups' => 'groups#index'
  get 'groups/new'
  get 'temp'  => 'groups#template'
  get 'signup' =>'devise/registrations#new'
  get 'rooms'  =>'home#rooms'
  get 'terms'  =>'home#terms'
  get 'news'   =>'home#news'
  get 'chatroom'   =>'groups#chatroom'
  resources :chatcomments, only: [:new, :create, :index]
  resources :groupchatcomments, only: [:new, :create, :index]
  
   match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
   devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => 'registrations' }

   
   resources :friendships
   resources :groupchatcomments, only: [:new, :create, :index]
 
 
  # devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
resources :activities
get 'users/show'

  resources :users do
    member do
      get :following, :followers
    end
  end
 

  
  get 'terms' => 'home#terms'
  get 'privacy' => 'home#privacy'
  get 'about' => 'home#about'
  resources :group_memberships
    
  
  resources :posts  do
      member { post :vote }
    resources :comments do
      member { post :vote }
    end
    end
  
  resources :groups do
    member do
      get :join_group ,:leave_group    
    end
    resources :groupchatcomments, only: [:new, :create, :index]
  
    resources :grouposts,          only: [:create, :destroy, :show] do
        resources :groupcomments
    end
  
 end
  resources :relationships,       only: [:create, :destroy]

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


   resources :conversations do
    get 'conversations'  =>'conversations#index'
  get "conversations/inbox" => "conversations#inbox", as: :mailbox_inbox
  get "conversations/sent" => "conversations#sent", as: :mailbox_sent
  get "conversations/trash" => "conversations#trash", as: :mailbox_trash
  resources :messages
  end
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
