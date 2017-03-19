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

  $('.prov-links').on('click', function(){
    var provider = this.innerText
    $.ajax({
      url: "/api/v1/providers/" + this.innerText,
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
  })

  $(function() {
    $("#datepicker-start").datepicker();
  });

  $(function() {
    $("#datepicker-end").datepicker();
  });
});
