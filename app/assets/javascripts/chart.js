$(document).ready(function() {
  $.ajax({
    url: "/api/v1/providers/global_data",
    type: 'GET',
    success: function(){
      $.get(this.url, function(csv) {
            $('#container').highcharts({
                chart: {
                    type: 'line'
                },
                data: {
                    csv: csv["thing"]
                },
                title: {
                    text: 'Global'
                },
                yAxis: {
                    title: {
                        text: 'Units'
                    }
                }
            });
        });
    }
  });

  $('.global').on('click', function(){
    $.ajax({
      url: "/api/v1/providers/global_data",
      type: 'GET',
      success: function(){
        $.get(this.url, function(csv) {
              $('#container').highcharts({
                  chart: {
                      type: 'line'
                  },
                  data: {
                      csv: csv["thing"]
                  },
                  title: {
                      text: "Global"
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
  $('.multiple-providers-percent-topfive').on('click', appendPercentGraphsTopFive)
});
