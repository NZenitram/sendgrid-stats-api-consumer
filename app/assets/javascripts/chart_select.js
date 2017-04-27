$(document).ready(function() {

});

function appendGraphs(){
  var btn = this
  clearGraphs();
  setActive(btn);
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>'
     + '<div id="events-blocks"><div id="spam"><div id="percentages-label"><span class="percentages-text">Spam</span></div><div id="percentages-number"><span class="spam'+ provider +'"></span></div></div>'
     + '<div id="opens"><div id="percentages-label"><span class="percentages-text">Opens</span></div><div id="percentages-number"><span class="opens'+ provider +'"></span></div></div>'
     + '<div id="clicks"><div id="percentages-label"><span class="percentages-text">Clicks</span></div><div id="percentages-number"><span class="clicks'+ provider +'"></span></div></div></div>')
     collectData(provider)
    //  populatePercentages(provider)
   }
}

function clearGraphs(){
  var btn = this
  setActive(btn);
  $('#graphs').children().remove();  
}
  /**
   * Create the chart when all data is loaded
   */
  function populateGraphs(provider, seriesOptions) {
      Highcharts.stockChart(provider, {
          title: {
          	text: provider
      		},
          legend: {
              enabled: true,
              align: 'right',
              backgroundColor: '#FCFFC5',
              borderColor: 'black',
              borderWidth: 2,
              layout: 'vertical',
              verticalAlign: 'top',
              y: 100,
              shadow: true
          },

          rangeSelector: {
              selected: 4
          },

          yAxis: {
              labels: {
                  formatter: function () {
                    return (this.value > 0 ? '' : '') + this.value;
                  }
            },
              plotLines: [{
                  value: 0,
                  width: 2,
                  color: 'silver'
              }]
          },

          plotOptions: {
              series: {
                  compare: 'events',
                  showInNavigator: true
              }
          },

          series: seriesOptions,

          tooltip: {
            enabled: true,
            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
            valueDecimals: 2,
            // split: true,
          }

      });
    }

function collectData(provider){
  var seriesOptions = [],
      seriesCounter = 0,
      names = ['delivered', 'opens', 'clicks', 'spam_reports', 'deferred', 'blocks', 'bounces', 'drops', 'unique_clicks', 'unique_opens'];
  $.each(names, function (i, name) {
    $.getJSON("http://localhost:3000/api/v1/provider-delivered/" + provider + '/' + name, function (data) {
      seriesOptions[i] = {
        name: name,
        data: data
      };
      // As we're loading the data asynchronously, we don't know what order it will arrive. So
      // we keep a counter and create the chart when all the data is loaded.
      seriesCounter += 1;

      if (seriesCounter === names.length) {
        populateGraphs(provider, seriesOptions);
      }

    });
  });
}
