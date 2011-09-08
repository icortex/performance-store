function remove_fields(link) {
    jq(link).prev("input[type=hidden]").val("1");
    jq(link).closest(".fields").hide();
}

function add_fields(selector, association, content, j_tokenize) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    content = '<tr class="fields">' + content + '</tr>';
    jq(selector).before(content.replace(regexp, new_id));
    console.log(j_tokenize);

    autocomplete_product('#lot_lot_products_attributes_' + new_id, '', '');
}