$(document).ready(function() {
var counter = 0
  $('.multiple-providers').on('click', function appendGraphs(){
    var checked = $('.providerCheckBox:checkbox:checked')
    for (var i = 0; i < checked.length; i++) {
      var provider = checked[i].parentElement.innerText
      $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
      populateGraphs(provider)
    }
  })

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

  $('#clear-button').on('click', clearGraphs)
});

function clearGraphs(){
  $('#graphs').children().empty()
}
