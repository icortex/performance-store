module ProductsHelper

  def set_default_color_size
    params[:size_ids] = {Size.first.size => Size.first.id} if  !params[:size_ids]
    params[:color_ids]={Color.first.color => Color.first.id} if  !params[:color_ids]
  end

  #[{:reference => 'perro', :brand => 'Adidas',  :sizes => {'s' =>{'am'=>[1,20]}, 'm'=> {'ne'=>[21,2]}}}, {}]

  def organize(products, hq_aware=true)
    pm = []
    products.each do |p|

      if hq_aware
        stocks_by_hq = p.stocks.find_by_headquarter_id(current_user.headquarter_id)
        qty = stocks_by_hq.quantity rescue 0
        price = stocks_by_hq.price rescue 0
      else

        qty = 0
        price = 0
      end

      pm_i = search_ref pm, p.reference
      if pm_i
        s = search_size pm_i, p.size.name
        if s
          pm_i[:sizes][s][p.color.name] = [qty, price]
        else
          pm_i[:sizes][p.size.name] = {p.color.name=>[qty, price]}
        end
      else
        product_temp = {}
        product_temp[:id] = p.reference
        product_temp[:brand] = p.brand.brand
        product_temp[:reference] = p.reference
        feature_to_insert = {}
        feature_to_insert[p.size.name] = {}
        feature_to_insert[p.size.name][p.color.name] = [qty, price]
        product_temp[:sizes] = feature_to_insert
        pm << product_temp
      end
    end
    pm
  end


  #  [{:reference => 'perro', :features =>{'s'=>{'am'=>[1,2]}}},{}]
  def search_ref products_modified, reference
    products_modified.each do |pm|
      if pm[:reference]==reference
        return pm
      end
    end
    false
  end

  def search_size product_modified, size
    product_modified[:sizes].each do |sz, v|
      if sz==size
        return sz
      end
    end
    false
  end

  def checked_if_included arg1, arg2
    arg1.include?(arg2) ? :checked : nil if arg1
  end

  def search_size_color old_product, size_ids, color_ids
    ret_val=false
    size_ids.values.each do |size|
      color_ids.values.each do |color|
        if old_product.color_id == color.to_i && old_product.size_id == size.to_i
          ret_val = [color.to_i, size.to_i]
        end
      end
    end
    ret_val
  end
end
