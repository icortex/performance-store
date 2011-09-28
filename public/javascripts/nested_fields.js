function remove_fields(link) {
    jq(link).closest('tr').find('input[type="hidden"][id*="_destroy"]').val('1');
    jq(link).closest(".fields").hide();
    jq(link).closest('tr').find('label[for*="subtotal"]').html('0');
    jq(link).closest('tr').find('input[id*="quantity"]').attr('min',0);
    jq(link).closest('tr').find('input[id*="quantity"]').val(0);
    calculate_total();
}

function add_fields(selector, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    content = '<tr class="fields">' + content + '</tr>';
    jq(selector).before(content.replace(regexp, new_id));
    autocomplete_product('#sale_sale_products_attributes_' + new_id, '', '');
}