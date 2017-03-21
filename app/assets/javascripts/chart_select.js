$(document).ready(function() {
var counter = 0
  $('.multiple-providers').on('click', appendGraphs)

  $('#clear-button').on('click', clearGraphs)
});


function appendGraphs(){
  clearGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/\s+/g, '');
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
     populateGraphs(provider)
   }
}

function clearGraphs(){
  $('#graphs').children().remove()
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
