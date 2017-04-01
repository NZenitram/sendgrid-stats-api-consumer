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

  $('.multiple-providers').on('click', appendGraphs, setActive)
  $('#clear-button').on('click', clearGraphs, setActive)
  $('.multiple-providers-percent').on('click', appendPercentGraphs, setActive)
  $('.multiple-providers-percent-topfive').on('click', appendPercentGraphsTopFive)

function setActive(){
  if (this.id == "provider-button") {
    $('#percentage-button').removeClass('active');
    $('#provider-button').addClass('active');
  } else if (this.id == 'percentage-button') {
    $('#provider-button').removeClass('active');
    $('#percentage-button').addClass('active');
  } else if (this.id == 'clear-button') {
    $('#percentage-button').removeClass('active');
    $('#provider-button').removeClass('active');
  }
}
});
