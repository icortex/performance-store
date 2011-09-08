module ApplicationHelper
  def is_active?(*controller)
    "background-color:#164d68" if  controller.include? params[:controller]
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association, css_selector, tokenize=false)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s + "_fields", :f => builder)
    end
#    css_selector = '#add_product'
    link_to_function(name, "add_fields('#{css_selector}', '#{association}', '#{escape_javascript(fields)}',#{tokenize});")
  end

  # Match the reference, size and color of a product with the corresponding id
  def set_ids products
    products.each do |k, sp|
      size= Size.find_by_size sp[:size]
      color = Color.find_by_color sp[:color]
      if !size.nil?
        p= Product.where("reference = ? and size_id = ? and color_id = ?", sp[:reference], size.id, color.id)[0]
        sp[:product_id] = p.id
      end
    end
  end
end
