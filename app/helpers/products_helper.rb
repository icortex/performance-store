module ProductsHelper

  def set_default_color_size
    if  !params[:product][:size]
      params[:product][:size]=[[Size.find(1).size, "1"]]
    end
    if  !params[:product][:color]
      params[:product][:color]=[[Color.find(1).color, "1"]]
    end
  end

  #[{:reference => 'perro', :brand => 'Adidas',  :sizes => {'s' =>{'am'=>[1,20]}, 'm'=> {'ne'=>[21,2]}}}, {}]

  def organize(options)
    pm = []
    options.each do |p|

      stocks_by_hq = p.stocks.find_by_headquarter_id(current_user.headquarter_id)
      qty = stocks_by_hq.quantity rescue 0
      price = stocks_by_hq.price rescue 0

      pm_i = search_ref pm, p.reference
      if pm_i
        s = search_size pm_i, p.size.size
        if s
          pm_i[:sizes][s][p.color.color] = [qty, price]
        else
          pm_i[:sizes][p.size.size] = {p.color.color=>[qty, price]}
        end
      else
        product_temp = {}
        product_temp[:id] = p.reference
        product_temp[:brand] = p.brand.brand
        product_temp[:reference] = p.reference
        feature_to_insert = {}
        feature_to_insert[p.size.size] = {}
        feature_to_insert[p.size.size][p.color.color] = [qty, price]
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
end
