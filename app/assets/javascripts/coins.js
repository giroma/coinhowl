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
      "minPeriod": "hh"
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
        "title": "Value",
        "showCategoryAxis": false,
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
          "negativeLineColor": "red",
          "negativeFillColors": "red",
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
        "title": "Price",
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
        "count": 2,
        "label": "1 hour"

      }, {
        "period": "hh",
        "count": 48,
        "label": "2 days"
      }, {
        "period": "hh",
        "count": 120,
        "label": "5 days"
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
  // setInterval(function () {
  //   $.ajax({
  //     url: `https://min-api.cryptocompare.com/data/pricemultifull?fsyms=TIX&tsyms=BTC&e=Bittrex`,
  //     method: 'GET'
  //
  //   }).done(function (response) {
  //     console.log('5 sec');
  //   })
  //
  // },5000)

}// end of if

// the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
// $('.modal-trigger').leanModal();
 $('.modal').modal();

}); //end of DOMContentLoaded
