module ApplicationHelper
  def is_active?(*controller)
    "background-color:#164d68" if  controller.include? params[:controller]
  end
end
