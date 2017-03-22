$(document).ready(function() {
  appendTopFive()
  $('#clear-button').on('click', clearGraphs)
  $('.multiple-providers').on('click', appendGraphs)
});

function appendTopFive(){
  var providers = $('#side-provider .prov-links')
  for (var i = 0; i < providers.length; i++) {

    var provider = providers[i].innerText.replace(/[^a-zA-Z0-9]/g, '');
    $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
    populateGraphs(provider)
  }
}

function appendGraphs(){
  clearGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
     populateGraphs(provider)
   }
}

function populateGraphs(provider){
    $.ajax({
      url: "/api/v1/providers/" + provider,
      type: 'GET',
      success: function(){
        var checked = $('.providerCheckBox:checkbox:checked')
        $.get(this.url, function(csv) {
              $('#'+ provider +'').highcharts({
                  chart: {
                      type: 'line'
                  },
                  data: {
                      csv: csv["thing"]
                  },
                  title: {
                      text: provider
                  },
                  yAxis: {
                      title: {
                          text: 'Units'
                      }
                  }
              });
          });
        }
      })
    }

function clearGraphs(){
  $('#top-five-graphs').children().remove()
}
