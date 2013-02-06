Sapphire::Application.routes.draw do
  resources :table_schemas do
    post :create_tag, :on => :collection
  end

  resources :tag_table_schemas, :only => [:show, :destroy] do
    post :dump_xml, :on => :collection
    post :dump_nsf, :on => :collection
  end

  resources :recommend_configs do
    get :batch_edit, :on => :collection
    post :batch_update, :on => :collection
  end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
