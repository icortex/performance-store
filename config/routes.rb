WJSport::Application.routes.draw do

  resources :variables

  scope(:path_names => {:new => 'nuevo', :edit => 'editar'}) do
    devise_for :users, :controllers => {:sessions => "sessions"}, :path => 'usuarios', :path_names => {:sign_up => 'registrar', :sign_in => 'iniciar_sesion'}

    resources :people, :path => 'clientes' do
      get 'cumpleanos' => 'people#index', :on => :collection, :as => :birthday
    end
    resources :lot_products
    resources :stocks, :path => 'inventario'
    resources :faulties
    resources :products, :path => 'articulos'
    resources :lots, :path => 'lotes'
    resources :headquarters
    resources :colors
    resources :brands
    resources :cloth_types
    resources :sizes
    resources :contacts
    resources :sale_products

    get "admin/validar" => "admin#validate", :as => :validate_users
    post "admin/validar" => "admin#validation", :as => :validate_users
    
    resources :sales, :path => 'ventas'
    resources :admin
    resources :expenses, :path => 'gastos'

    match 'reportes' => 'reports#index', :as => :reports
    post 'reportes' => 'reports#index'
    get "inventario/sede/:headquarter"=>'stocks#index'
    get "ventas/sede/:headquarter"=>'sales#index'

  end

  #match 'articulos/:id'=>'products#destroy',:via => 'delete'
  root :to => "passthrough#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end