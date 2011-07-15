/*
*  fieldset_selector='#sale_sale_products_attributes_'+#
*  # stands for a number, for example:1 , 2 , 3
 */
function autocomplete_product (fieldset_selector) {

    jq(fieldset_selector+'_product_id').tokenInput("/articulos.json", {
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
            fill_features(item,fieldset_selector);
        }
    });
}

function autocomplete_client(){
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
    size_select = jq(fieldset_selector+'_size').html('');
    color_select = jq(fieldset_selector+'_color').html('');
    jq.each(item.features, function(key, value) {
        if (jq("#sale_sale_products_attributes_0_size option[value='" + value.size + "']").length == 0) {
            size_select.
                    append(jq("<option></option>").
                    attr("value", value.size).
                    text(value.size));
        }
        if (jq("#sale_sale_products_attributes_0_color option[value='" + value.color + "']").length == 0) {
            color_select.
                    append(jq("<option></option>").
                    attr("value", value.color).
                    text(value.color));
        }
        console.log(value.price);
        jq("#sale_sale_products_attributes_0_price").val(value.price)
    });
}
