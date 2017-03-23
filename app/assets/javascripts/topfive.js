$(document).ready(function() {

});

function appendGraphsTopFive(){
  clearTopGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>'
     + '<div id="events-blocks"><div id="spam"><div id="percentages-label"><span class="percentages-text">Spam</span></div><div id="percentages-number"><span class="spam'+ provider +'"></span></div></div>'
     + '<div id="opens"><div id="percentages-label"><span class="percentages-text">Opens</span></div><div id="percentages-number"><span class="opens'+ provider +'"></span></div></div>'
     + '<div id="clicks"><div id="percentages-label"><span class="percentages-text">Clicks</span></div><div id="percentages-number"><span class="clicks'+ provider +'"></span></div></div></div>')
     populateGraphs(provider)
     populatePercentages(provider)
   }
}


function appendTopFive(){
  var providers = $('#side-provider .prov-links')
  for (var i = 0; i < providers.length; i++) {
    var provider = providers[i].innerText.replace(/[^a-zA-Z0-9]/g, '');
    $("#top-five-graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>'
    + '<div id="events-blocks"><div id="spam"><div id="percentages-label"><span class="percentages-text">Spam</span></div><div id="percentages-number"><span class="spam'+ provider +'"></span></div></div>'
    + '<div id="opens"><div id="percentages-label"><span class="percentages-text">Opens</span></div><div id="percentages-number"><span class="opens'+ provider +'"></span></div></div>'
    + '<div id="clicks"><div id="percentages-label"><span class="percentages-text">Clicks</span></div><div id="percentages-number"><span class="clicks'+ provider +'"></span></div></div></div>')
    populateGraphs(provider)
    populatePercentages(provider)
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

function clearTopGraphs(){
  $('#top-five-graphs').children().remove()
}
