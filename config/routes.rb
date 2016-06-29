Rails.application.routes.draw do
  
  resources :images
  resources :freeusers, only: [:show, :destroy, :index]
  resources :albums
  resources :albumsshows, only: [:show]
  devise_for :users, :controllers => { :registrations => 'registrations'}
  
  # get "login", to: 'freeusers#new'
  # post "login", to: 'freeusers#login'
  # post 'logout', to: 'freeusers#logout'
  post 'search_images', to: "images#search"
  post 'search_images_album', to: "albums#search"
  post 'search_freeusers', to: "freeusers#search"
  
  # get 'freeuser', to: "freeusers#show"
  # post 'delete_freeuser', to: "freeuser#destroy"
  # get 'user/edit/:id', to: "registrations#edit"
  # get "*any", via: :all, to: "errors#not_found"
  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]
  root 'welcome#index'

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
