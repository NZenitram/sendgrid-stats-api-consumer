$(document).ready(function() {

});


function appendGraphs(){
  clearGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>'
     + '<div id="events-blocks"><div id="spam"><div id="percentages-label"><span class="percentages-text">Spam</span></div><div id="percentages-number"><span class="spam'+ provider +'"></span></div></div>'
     + '<div id="opens"><div id="percentages-label"><span class="percentages-text">Opens</span></div><div id="percentages-number"><span class="opens'+ provider +'"></span></div></div>'
     + '<div id="clicks"><div id="percentages-label"><span class="percentages-text">Clicks</span></div><div id="percentages-number"><span class="clicks'+ provider +'"></span></div></div></div>')
     populateGraphs(provider)
     populatePercentages(provider)
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
                          text: 'Events'
                      }
                  }
              });
          });
        }
      })
    }

function appendPercentGraphs(){
  clearGraphs()
 var checked = $('.providerCheckBox:checkbox:checked')
   for (var i = 0; i < checked.length; i++) {
     var provider = checked[i].parentElement.innerText.replace(/[^a-zA-Z0-9]/g, '');
     $("#graphs").append('<div id='+ provider +' class="inline-display graph-data" style="min-width: 310px; height: 400px; margin: 0 auto"></div>'
     + '<div id="events-blocks"><div id="spam"><div id="percentages-label"><span class="percentages-text">Spam</span></div><div id="percentages-number"><span class="spam'+ provider +'"></span></div></div>'
     + '<div id="opens"><div id="percentages-label"><span class="percentages-text">Opens</span></div><div id="percentages-number"><span class="opens'+ provider +'"></span></div></div>'
     + '<div id="clicks"><div id="percentages-label"><span class="percentages-text">Clicks</span></div><div id="percentages-number"><span class="clicks'+ provider +'"></span></div></div></div>')
     populatePercentGraphs(provider)
     populatePercentages(provider)
   }
}


function populatePercentGraphs(provider){
    $.ajax({
      url: "/api/v1/providers/" + provider +"_percent",
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
                          text: 'Percent'
                      }
                  }
              });
          });
        }
      })
        }



function populatePercentages(provider){
  $.ajax({
    url: "/api/v1/percentage",
    type: 'GET',
    data: {provider: provider},
    success: function(response){
      grabProvider(response, provider);
    }
  })
}

function grabProvider(response, provider) {
  var spam = response.events.spam.toFixed(2)
  var clicks = response.events.click_percentage.toFixed(2)
  var opens = response.events.open_percentage.toFixed(2)
  $('.spam'+ provider +'')[0].innerText = spam + '%'
  $('.clicks'+ provider +'')[0].innerText = clicks + '%'
  $('.opens'+ provider +'')[0].innerText = opens + '%'
}
