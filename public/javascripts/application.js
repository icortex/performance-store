function remove_fields(link) {
  jq(link).prev("input[type=hidden]").val("1");
  jq(link).closest(".fields").hide();
}

function add_fields(selector, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  content = '<tr class="fields">'+content+'</tr>';
  console.log(jq(selector).before(content.replace(regexp,new_id)));
  console.log(content);
  autocomplete_product('#sale_sale_products_attributes_'+new_id);
}