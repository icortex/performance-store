WJSport::Application.routes.draw do

  scope(:path_names => {:new => 'nuevo', :edit => 'editar'}) do
    devise_for :users, :controllers => {:sessions => "sessions"}, :path => 'usuarios', :path_names => {:sign_up => 'registrar', :sign_in => 'iniciar_sesion'}

    resources :people, :path => 'clientes' do
      get 'cumpleanos' => 'people#index', :on => :collection, :as => :birthday
    end

    resources :stocks, :path => 'inventario'
    resources :products, :path => 'articulos'
    resources :lots, :path => 'lotes'
    resources :headquarters
    resources :colors
    resources :brands
    resources :cloth_types
    resources :sizes
    resources :contacts
    resources :variables

    get "admin/validar" => "admin#validate", :as => :validate_users
    post "admin/validar" => "admin#validation", :as => :validate_users

    resources :sales, :path => 'ventas'
    resources :admin
    resources :expenses, :path => 'gastos'
  end

  match 'reportes' => 'reports#index', :as => :reports
  post 'reportes' => 'reports#index'
  get "inventario/sede/:headquarter"=>'stocks#index'
  get "ventas/sede/:headquarter"=>'sales#index'

  root :to => "passthrough#index"
end