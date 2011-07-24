/*
 *  fieldset_selector='#sale_sale_products_attributes_'+#
 *  # stands for a number, for example:1 , 2 , 3
 */
function autocomplete_product(fieldset_selector) {

    jq(fieldset_selector + '_reference').tokenInput("/articulos.json", {
        crossDomain: false,
        //prePopulate: jq("#sale_product_tokens").data("pre"),
        search_parameter: "reference",
        searchingText: "Buscando...",
        noResultsText: "No hay resultados",
        hintText: "Ingrese la referencia del articulo...",
        onResult: function (results) {
            jq.each(results, function (index, value) {
                value.reference = value.brand + ', ' + value.reference;
            });
            return results;
        },
        onAdd: function (item) {
            fill_features(item, fieldset_selector);
        }
    });
}

function autocomplete_client() {
    var clients = 0;
    jq("#sale_person_id").tokenInput("/clientes.json", {
        crossDomain: false,
        //prePopulate: jq("#sale_product_tokens").data("pre"),
        search_parameter: "document_id",
        searchingText: "Buscando...",
        noResultsText: "No hay resultados",
        hintText: "Ingrese la cedula del cliente...",
        onResult: function (results) {
            jq.each(results, function (index, value) {
                value.document_id = value.name + ', ' + value.document_id;
            });
            return results;
        },
        onAdd: function (item) {
            if (clients == 0) {
                clients++;
            }
            else {
                jq("#sale_person_id").tokenInput("clear");
                //jq("#sale_person_id").tokenInput("add", { id: 1 , document_id:'some' });
                clients = 0;
            }
        }
    });
}

function fill_features(item, fieldset_selector) {
    var size_select = jq(fieldset_selector + '_size').html('');
    var color_select = jq(fieldset_selector + '_color').html('');
    var price_input = jq(fieldset_selector + '_price').html('');
    var quantity_input = jq(fieldset_selector + '_quantity').val('1');
    var label_for_selector = 'label[for=' + fieldset_selector.substr(1);
    var max_quantity_label = jq(label_for_selector + '_in_stock]').html('');
    var subtotal = jq(label_for_selector + '_subtotal]').html('');
    var total = jq('#sale_total');

    add_options(size_select['selector'], keys(item.sizes));
    var colors = update_colors(size_select.val(), item, color_select);
    update_price_quantity(colors, color_select.val(), price_input, max_quantity_label, subtotal, quantity_input);

    size_select.change(function() {
        colors = update_colors(size_select.val(), item, color_select);
        update_price_quantity(colors, color_select.val(), price_input, max_quantity_label, subtotal, quantity_input);
    });

    color_select.change(function() {
        update_price_quantity(colors, color_select.val(), price_input, max_quantity_label, subtotal, quantity_input);
    });

    quantity_input.keyup(function(evt) {
        subtotal.html(quantity_input.val() * price_input.val());
        console.log(evt);
        total.val(subtotal.html());
    });

    price_input.keyup(function() {
        subtotal.html(quantity_input.val() * price_input.val());
        total.val(subtotal.html());
    });
}

function keys(some_hash) {
    var ret_array = [];
    for (var key in some_hash) {
        ret_array.push(key);
    }
    return ret_array;
}

/*
 * options_array=[['value 1', 'value 2'],['content 1', 'content 2']]
 * OR
 * options_array=['value 1', 'value 2']
 */
function add_options(select_css_selector_str, options_array) {
    var i, el, select = jq(select_css_selector_str);
    if (!(typeof(options_array[0]) == 'object')) options_array = [options_array,options_array];
    for (i = 0; i < Math.max(options_array[0].length, options_array[1].length); i++) {
        var value = options_array[0][i];
        var content = options_array[1][i];
        var option = jq("<option value=''></option>");
        option.val(value);
        option.html(content);
        select.append(option);
    }
}
function update_colors(size_str, item, color_select) {
    var colors = item.sizes[size_str];
    color_select.html('');
    add_options(color_select['selector'], keys(colors));
    return colors;
}
function update_price_quantity(colors, color_str, price_input, max_quantity_label, subtotal, quantity_input) {
    var qty = colors[color_str][0];
    var price = colors[color_str][1];
    price_input.val(price);
    max_quantity_label.html(qty);
    subtotal.html(quantity_input.val() * price);
}