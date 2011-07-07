/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" id_element="#id_field">
*/
$(document).ready(function(){jq("input[data-autocomplete]").railsAutocomplete()}),function(a){var b=null;a.fn.railsAutocomplete=function(){return this.live("focus",function(){this.railsAutoCompleter||(this.railsAutoCompleter=new a.railsAutocomplete(this))})},a.railsAutocomplete=function(a){_e=a,this.init(_e)},a.railsAutocomplete.fn=a.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},a.railsAutocomplete.fn.extend=a.railsAutocomplete.extend=a.extend,a.railsAutocomplete.fn.extend({init:function(a){function c(a){return b(a).pop().replace(/^\s+/,"")}function b(b){return b.split(a.delimiter)}a.delimiter=jq(a).attr("data-delimiter")||null,jq(a).autocomplete({source:function(b,d){jq.getJSON(jq(a).attr("data-autocomplete"),{term:c(b.term)},function(){jq(arguments[0]).each(function(b,c){var d={};d[c.id]=c,jq(a).data(d)}),d.apply(null,arguments)})},search:function(){var a=c(this.value);if(a.length<2)return!1},focus:function(){return!1},select:function(c,d){var f=b(this.value);f.pop(),f.push(d.item.value);if(a.delimiter!=null)f.push(""),this.value=f.join(a.delimiter);else{this.value=f.join(""),jq(this).attr("id_element")&&jq(jq(this).attr("id_element")).val(d.item.id);if(jq(this).attr("data-update-elements")){var g=jq(this).data(d.item.id.toString()),h=jq.parseJSON(jq(this).attr("data-update-elements"));for(var i in h)jq(h[i]).val(g[i])}}var j=this.value;jq(this).bind("keyup.clearId",function(){jq(this).val().trim()!=j.trim()&&(jq(jq(this).attr("id_element")).val(""),jq(this).unbind("keyup.clearId"))}),jq(this).trigger("railsAutocomplete.select");return!1}})}})}(jQuery)