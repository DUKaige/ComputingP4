Rails.application.routes.draw do
  #for test only
  get "/mytest" => "application#mytest"




  # Routes for the News resource:
  # CREATE
  get '/new_news' => 'news#new'
  get '/create_news' => 'news#create'

  # READ
  get '/news' => 'news#index'
  get '/news/:id' => 'news#show'

  # UPDATE
  get '/news/:id/edit' => 'news#edit'
  get '/news/:id/update' => 'news#update'

  # DELETE
  get '/news/:id/destroy' => 'news#destroy'
  #------------------------------

  # Routes for the School resource:
  # CREATE
  get '/new_school' => 'schools#new'
  get '/create_school' => 'schools#create'

  # READ
  get '/schools' => 'schools#index'
  get '/schools/:id' => 'schools#show'

  # UPDATE
  get '/schools/:id/edit' => 'schools#edit'
  get '/schools/:id/update' => 'schools#update'

  # DELETE
  get '/schools/:id/destroy' => 'schools#destroy'
  #------------------------------

  get "/school_children" => "schools#show_related_children"





  # Routes for the Donator resource:
  # CREATE
  get '/new_donator' => 'donators#new'
  get '/create_donator' => 'donators#create'

  # READ
  get '/donators' => 'donators#index'
  get '/donators/:id' => 'donators#show'

  # UPDATE
  get '/donators/:id/edit' => 'donators#edit'
  get '/donators/:id/update' => 'donators#update'

  # DELETE
  get '/donators/:id/destroy' => 'donators#destroy'
  #------------------------------

  get "/donator_news" => 'donators#show_related_news'
  get "/donator_children" => 'donators#show_related_children'
  get "donator_schools" => "donators#show_related_schools"
  get "/donator_account" => "donators#account"






  # Routes for the Child resource:
  # CREATE
  get '/new_child' => 'children#new'
  get '/create_child' => 'children#create'

  # READ
  get '/children' => 'children#index'
  get '/children/:id' => 'children#show'

  # UPDATE
  get '/children/:id/edit' => 'children#edit'
  get '/children/:id/update' => 'children#update'

  # DELETE
  get '/children/:id/destroy' => 'children#destroy'
  get '/donateachild/:id' => 'children#donate'

  get '/change_status/:id' => 'children#change_status'






  get '/' => 'application#main'
  get '/login'=>'application#login'
  get '/signup'=>'application#signup'
  get '/sign_in' => 'application#sign_in'
  get '/sign_out' => "application#sign_out"
  get '/error_page'=> "application#error_page"
  #------------------------------

  # Routes for the Child resource:
  # CREATE
  #------------------------------

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
