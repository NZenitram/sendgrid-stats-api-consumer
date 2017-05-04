$(document).ready(function() {
});

$('.top-five-providers').on('click', appendGraphsTopFive)
$('#clear-top-five-button').on('click', clearTopGraphs)

function appendTopFive(){
  clearTopGraphs()
  var providers = $('#providers-select').find('option').not(':selected')
  for (var i = 0; i < providers.length; i++) {
    var provider = providers[i].innerText.replace(/[^a-zA-Z0-9]/g, '');
    $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
    collectData(provider)
  }
}

function appendGraphsTopFive(){
  clearTopGraphs()
 var checked = $('#providers-select').val()
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i]
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
   }
}

function appendPercentGraphsTopFive(){
  clearTopGraphs()
 var checked = $('#providers-select').val()
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i]
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
   }
}


function clearTopGraphs(){
  $('#top-five-graphs').children().remove()
}
