function remove_fields(link) {
  jq(link).prev("input[type=hidden]").val("1");
  jq(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  jq(link).parent().before(content.replace(regexp, new_id));
}