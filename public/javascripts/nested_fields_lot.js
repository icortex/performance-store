function remove_fields(link) {
    jq(link).closest('tr').find('input[type="hidden"][id*="_destroy"]').val('1');
    jq(link).closest(".fields").find('input[name*=quantity]').val(0);
    update_freight();
    jq(link).closest(".fields").hide();
}

function add_fields(selector, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    content = '<tr class="fields">' + content + '</tr>';
    jq(selector).before(content.replace(regexp, new_id));
    autocomplete_product('#lot_lot_products_attributes_' + new_id, '', '');
}