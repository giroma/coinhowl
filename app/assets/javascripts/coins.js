// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

  // # Sorting by
  document.addEventListener("DOMContentLoaded", function(event) {
    if (document.getElementById('chartdiv')) {

  var info = document.getElementById('chartdiv');
  var chartData = JSON.parse(info.dataset.chartarray);
  var coinSymbol = info.dataset.coinsymbol;

  var chart = AmCharts.makeChart( "chartdiv", {
    "type": "stock",
    "theme": "light",
    "mouseWheelScrollEnabled": false,
    "mouseWheelZoomEnabled": true,

    "categoryAxesSettings": {
      "minPeriod": "mm"
    },

    "dataSets": [ {
      "fieldMappings": [ {
        "fromField": "open",
        "toField": "open"
      }, {
        "fromField": "close",
        "toField": "close"
      }, {
        "fromField": "high",
        "toField": "high"
      }, {
        "fromField": "low",
        "toField": "low"
      }, {
        "fromField": "volumefrom",
        "toField": "volumefrom"
      }, {
        "fromField": "value",
        "toField": "value"
      } ],

      "color": "#1565C0",
      "dataProvider": chartData,
      "title": coinSymbol,
      "categoryField": "date"
    }, {
      "fieldMappings": [ {
        "fromField": "value",
        "toField": "value"
      } ],

    } ],


    "panels": [ {
        "title": "Price",
        "showCategoryAxis": true,
        "percentHeight": 70,
        "valueAxes": [ {
          "dashLength": 5
        } ],

        "categoryAxis": {
          "dashLength": 5
        },

        "stockGraphs": [ {
          "type": "candlestick",
          "id": "g1",
          "openField": "open",
          "closeField": "close",
          "highField": "high",
          "lowField": "low",
          "valueField": "close",
          "lineColor": "green",
          "fillColors": "green",
          "negativeLineColor": "#DF1313",
          "negativeFillColors": "#DF1313",
          "fillAlphas": 1,
          "useDataSetColors": false,
          "comparable": true,
          "compareField": "value",
          "showBalloon": true,
          "balloonText": "Open:<b>[[open]]</b><br>Low:<b>[[low]]</b><br>High:<b>[[high]]</b><br>Close:<b>[[close]]</b><br>",
        } ],
          "chartCursor": {
          "valueLineEnabled": true,
          "valueLineBalloonEnabled": true
        },
          "categoryField": "date",
          "categoryAxis": {
          "parseDates": true
        },
        "stockLegend": {
          "valueTextRegular": undefined,
          "periodValueTextComparing": "[[percents.value.close]]%"
        }
      },

      {
        "title": "Volume",
        "percentHeight": 30,
        "marginTop": 1,
        "showCategoryAxis": true,
        "valueAxes": [ {
          "dashLength": 5
        } ],

        "categoryAxis": {
          "dashLength": 5
        },

        "stockGraphs": [ {
          "valueField": "volume",
          "type": "column",
          "showBalloon": true,
          "fillAlphas": 1
        } ],

        "stockLegend": {
          "markerType": "none",
          "markerSize": 0,
          "labelText": "",
          "periodValueTextRegular": "[[value.close]]"
        }
      }
    ],

    "chartScrollbarSettings": {
      "autoGridCount": true,
      "graph": "g1",
      "graphType": "line",
      "usePeriod": "DD"
    },

    "periodSelector": {
      "inputFieldsEnabled": false,
      "position": "top",
      "periods": [ {
        "period": "hh",
        "count": 1,
        "label": "1 hour"

      }, {
        "period": "hh",
        "count": 6,
        "label": "6 hours"
      }, {
        "period": "hh",
        "count": 24,
        "label": "1 days"
      }, {
        "period": "hh",
        "count": 72,
        "label": "3 days"
      }, {
        "period": "hh",
        "count": 144,
        "label": "7 days",
      }, {
        "period": "MAX",
        "label": "MAX"
      } ]
    }
  } );
  // update show page prices every 5 seconds
  setInterval(function () {
    var coinSymbol = $('.js-coin-symbol').text() //get coin name from html element
    $.ajax({
      url: `https://cors-anywhere.herokuapp.com/https://bittrex.com/api/v1.1/public/getmarketsummary?market=btc-${coinSymbol}`,
      method: 'GET'
    }).done(function (response) {
      $('.coin-prices-table tr').each(function () { // itterate over each element
        var field = $(this).find('td').eq(1).find('h5').attr('data-field') // get the field name for the h5 of every second dt
        $(this).find('td').eq(1).find('h5').html('&#579; ' + (response['result'][0][field]).toFixed(8)) // now change the text with new data
      })
    })
  },5000)

}// end of if

// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
// $('.modal-trigger').leanModal();
 $('.modal').modal();

}); //end of DOMContentLoaded
