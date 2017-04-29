$(document).ready(function() {

});

function appendGraphs(){
  var btn = this
  clearGraphs();
  setActive(btn);
 var checked = $('#providers-select').val()
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i]
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
     collectData(provider)
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
    Highcharts.setOptions({
      lang: {
        thousandsSep: ','
      },
    });
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

              opposite: false,

              labels: {
                  formatter: function () {
                    return (this.value > 0 ? '' : '') + this.value;
                  },
                  style: {
                    fontSize:'15px'
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
            // valueDecimals: 2,
            // split: true,
          },

          exporting: {
            sourceWidth: 1600,
            sourceHeight: 400,
            // scale: 2 (default)
            chartOptions: {
                subtitle: null
              }
          }

      });
    }

function collectData(provider){
  var seriesOptions = [],
      seriesCounter = 0,
      names = ['delivered', 'opens', 'clicks', 'spam_reports', 'deferred', 'blocks', 'bounces', 'unique_clicks', 'unique_opens'];
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


function appendPercentGraphs(){
  var btn = this
  clearGraphs();
  setActive(btn);
 var checked = $('#providers-select').val()
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i]
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>')
     collectPercentageData(provider)
   }
}

/**
 * Create the chart when all data is loaded
 */
function populatePercentGraphs(provider, seriesOptions) {
    Highcharts.stockChart(provider, {
        title: {
          text: provider + " Percentage"
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

            opposite: false,

            labels: {
                formatter: function () {
                  return (this.value > 0 ? '' : '') + this.value;
                },

                style: {
                  fontSize:'15px'
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
          split: true,
        },

        exporting: {
          sourceWidth: 1600,
          sourceHeight: 400,
          // scale: 2 (default)
          chartOptions: {
              subtitle: null
            }
        }
    });
  }

function collectPercentageData(provider){
var seriesOptions = [],
    seriesCounter = 0,
    names = ['open_percentage', 'click_percentage', 'spam_report_percentage'];
$.each(names, function (i, name) {
  $.getJSON("http://localhost:3000/api/v1/provider-percentages/" + provider + '/' + name, function (data) {
    seriesOptions[i] = {
      name: name,
      data: data
    };
    // As we're loading the data asynchronously, we don't know what order it will arrive. So
    // we keep a counter and create the chart when all the data is loaded.
    seriesCounter += 1;

    if (seriesCounter === names.length) {
      populatePercentGraphs(provider, seriesOptions);
    }

  });
});
}
