$(document).ready(function() {
page = $('body')[0].baseURI
  switch (page) {
    case 'http://localhost:3001/top-five.html':
    case "https://www.simplymailstatistics.com/top-five.html":
      appendTopFive()
      break;
  case "http://localhost:3001/global.html":
  case "https://www.simplymailstatistics.com/global.html":
  var seriesOptions = [],
      seriesCounter = 0,
      names = ['blocks', 'bounces', 'clicks', 'deferred', 'delivered', 'opens', 'processed', 'spam_reports', 'unique_clicks', 'unique_opens', 'unsubscribes'];

function globalGraph(){
  Highcharts.setOptions({
    lang: {
      thousandsSep: ','
    },
  });
      Highcharts.stockChart('container', {
          title: {
            text: "Global Data"
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

  $.each(names, function (i, name) {
    $.getJSON(urlEndpoint + '/api/v1/global-events/' + name + '/' + user_id, function (data) {
      seriesOptions[i] = {
        name: name,
        data: data
      };
      // As we're loading the data asynchronously, we don't know what order it will arrive. So
      // we keep a counter and create the chart when all the data is loaded.
      seriesCounter += 1;

      if (seriesCounter === names.length) {
        globalGraph();
      }

    });
  });
  break
}

  $(function() {
    $("#datepicker-start").datepicker();
  });

  $(function() {
    $("#datepicker-end").datepicker();
  });

  $('.multiple-providers').on('click', appendGraphs)
  $('#clear-button').on('click', clearGraphs)
  $('#clear-button').on('click', clearTopGraphs)
  $('.multiple-providers-percent').on('click', appendPercentGraphs)
  $('.multiple-providers-percent-topfive').on('click', appendPercentGraphsTopFive)
});

function setActive(btn){
  if (btn.id == "provider-button") {
    $('#percentage-button').removeClass('active');
    $('#provider-button').addClass('active');
  } else if (btn.id == 'percentage-button') {
    $('#provider-button').removeClass('active');
    $('#percentage-button').addClass('active');
  } else if (btn.id == 'clear-button') {
    $('#percentage-button').removeClass('active');
    $('#provider-button').removeClass('active');
  }
}
