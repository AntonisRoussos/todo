Todo::Application.routes.draw do 


  resources :categories

  resources :subcategories

  resources :expense_journals

#  resources :expenses

  root :to => "home#index"
  match 'users/activateuser/:id', :to => 'users#activateuser'
  match '/users/:id/reset',  :to => 'users#updatepasswordreset'
  match '/signup/users/check_email', :to => 'users#check_email'
  match '/signup/users/check_name', :to => 'users#check_name'
  resources :users 
  resources :sessions, :only => [:new, :create, :destroy]
  get "sessions/new"
  match '/signup',  :to => 'users#new'
  match '/MailPasswordRequest',  :to => 'users#MailPasswordRequest'
  match '/MailPassword',  :to => 'users#MailPassword'
  match 'MailPassword/ResetPasswordRequest/:encryptedhash', :to => 'users#ResetPasswordRequest'
  match '/ResetPassword',  :to => 'users#ResetPassword'
  match '/ChangePasswordRequest',  :to => 'users#ChangePasswordRequest'
  match '/ChangePassword',  :to => 'users#ChangePassword'
  match '/DownloadMobile', :to => 'users#DownloadMobile'
  match '/signin',  :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/MapRequest',  :to => 'places#MapRequest'
  match '/MapOfPlace',  :to => 'places#MapOfPlace'
  match 'tasks/show',  :to => 'tasks#show'
  match 'tasks/show1',  :to => 'tasks#show1'
  match 'tasks/destroy',  :to => 'tasks#destroy'
  match '/signup/users/check_name', :to => 'users#check_name'
  match 'tasks/check_date_due', :to => 'tasks#check_date_due'
  match '/tasks/retrieve_day',  :to => 'tasks#retrieve_day'
  match '/tasks/update',  :to => 'tasks#update'
  resources :tasks 
  match '/expenses/synchronize_with_mobile',  :to => 'expenses#synchronize_with_mobile'
  match '/expenses/synchronize_with_mobile_second_step',  :to => 'expenses#synchronize_with_mobile_second_step'
  match '/expenses/authenticate_mobile_user',  :to => 'expenses#authenticate_mobile_user'
  match '/expenses/copy_to_mobile',  :to => 'expenses#copy_to_mobile'
  match '/fix_user_id',  :to => 'expenses#fix_user_id'
  match '/expenses/shownew',  :to => 'expenses#shownew'
  match '/expenses/show1',  :to => 'expenses#show1'
  match '/expenses/getSubcategories',  :to => 'expenses#getSubcategories'
  match 'expenses/check_date_due', :to => 'expenses#check_date_due'
  resources :expenses 

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
