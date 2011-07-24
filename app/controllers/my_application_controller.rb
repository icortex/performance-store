class MyApplicationController < ApplicationController
  load_and_authorize_resource
  check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to request.referer, :alert => 'Permiso denegado'
  end
end
