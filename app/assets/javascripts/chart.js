$(document).ready(function() {
  var seriesOptions = [],
      seriesCounter = 0,
      names = ['blocks', 'bounce_drops', 'bounces', 'clicks', 'deferred', 'delivered', 'invalid_emails', 'opens', 'processed', 'requests', 'spam_report_drops', 'spam_reports', 'unique_clicks', 'unique_opens', 'unsubscribe_drops', 'unsubscribes'];

function globalGraph(){
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

  $.each(names, function (i, name) {
    $.getJSON("https://still-spire-69165.herokuapp.com/api/v1/global-events/" + name, function (data) {
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

  $(function() {
    $("#datepicker-start").datepicker();
  });

  $(function() {
    $("#datepicker-end").datepicker();
  });

  $('.multiple-providers').on('click', appendGraphs)
  $('#clear-button').on('click', clearGraphs)
  $('.multiple-providers-percent').on('click', appendPercentGraphs)
  // $('.multiple-providers-percent-topfive').on('click', appendPercentGraphsTopFive)
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
