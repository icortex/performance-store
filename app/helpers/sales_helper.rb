module SalesHelper
  include ProductsHelper

  def set_ids sale_products
    sale_products.each do |k, sp|
      size= Size.find_by_size sp[:size]
      color = Color.find_by_color sp[:color]
      if !size.nil?
        p= Product.where("reference = ? and size_id = ? and color_id = ?", sp[:reference], size.id, color.id)[0]
        sp[:product_id] = p.id
      end
    end
  end
end
