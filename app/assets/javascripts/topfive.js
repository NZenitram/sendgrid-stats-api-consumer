$(document).ready(function() {

});

function appendGraphsTopFive(){
  clearTopGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
   }
}

function appendPercentGraphsTopFive(){
  clearTopGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
   }
}

function appendTopFive(){
  clearTopGraphs()
  var providers = $('#side-provider .prov-links')
  for (var i = 0; i < providers.length; i++) {
    var provider = providers[i].innerText.replace(/[^a-zA-Z0-9]/g, '');
    $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
    collectData(provider)
  }
}

function clearTopGraphs(){
  $('#top-five-graphs').children().remove()
}
