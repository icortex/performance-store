WJSport::Application.routes.draw do

  scope(:path_names => {:new => 'nuevo', :edit => 'editar'}) do
    devise_for :users, :controllers => {:sessions => "sessions"}, :path => 'usuarios', :path_names => {:sign_up => 'registrar', :sign_in => 'iniciar_sesion'}

    resources :people, :path => 'clientes' do
      get 'cumpleanos' => 'people#index', :on => :collection, :as => :birthday
    end

    resources :stocks, :path => 'inventario'
    resources :products, :path => 'articulos'
    resources :lots, :path => 'lotes' do
      get ':id/inventario' => 'lots#stock', :on => :collection, :as => :stock
    end
    resources :headquarters
    resources :colors
    resources :brands
    resources :cloth_types
    resources :sizes
    resources :variables
    resources :carriers, :path => 'transportador'


    get "admin/validar" => "admin#validate", :as => :validate_users
    post "admin/validar" => "admin#validation", :as => :validate_users

    resources :sales, :path => 'ventas' do
      get 'abono' => 'sales#payment', :as=> :payment
    end
    resources :admin
    resources :expenses, :path => 'gastos'
  end

  match 'reportes' => 'reports#index', :as => :reports
  post 'reportes' => 'reports#index'
  get "inventario/sede/:headquarter"=>'stocks#index'
  get "ventas/sede/:headquarter"=>'sales#index'
  get "gastos/sede/:headquarter"=>'expenses#index'

  root :to => "passthrough#index"
end