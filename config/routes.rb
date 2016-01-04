Rails.application.routes.draw do
  #for test only
  get "/mytest" => "application#mytest"


  # Routes for the News resource:
  # CREATE
  get '/new_news' => 'news#new'
  get "/create_news/:id" => "news#create"
  get '/new_news/:id' => 'news#new'
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
  get '/schools_edit' => 'schools#edit'
  get '/schools_update' => 'schools#update'

  # DELETE
  get '/schools/:id/destroy' => 'schools#destroy'
  #------------------------------

  get "/school_children" => "schools#show_related_children"
  get "/school_news" => "schools#show_related_news"
  get "/school_account" => "schools#account"
  get "/school_change_password" => "schools#change_password"
  get "/school_update_password" => "schools#update_password"


  # Routes for the Donator resource:
  # CREATE
  get '/new_donator' => 'donators#new'
  get '/create_donator' => 'donators#create'

  # READ
  get '/donators' => 'donators#index'
  get '/donators/:id' => 'donators#show'

  # UPDATE
  get '/donators_edit' => 'donators#edit'
  get '/donators_update' => 'donators#update'

  # DELETE
  get '/donators/:id/destroy' => 'donators#destroy'
  #------------------------------

  get "/donator_children" => 'donators#show_related_children'
  get "donator_schools" => "donators#show_related_schools"
  get "/donator_account" => "donators#account"

  get "/donator_change_password" => "donators#change_password"
  get "/donator_update_password" => "donators#update_password"




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
  get '/contact' => "application#contact"

end
