// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery2
//= require rails-ujs
//= require turbolinks
//= require materialize
//= require_tree .
document.addEventListener("DOMContentLoaded", function(event) {

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
        "lineColor": "#7f8da9",
        "fillColors": "#7f8da9",
        "negativeLineColor": "#db4c3c",
        "negativeFillColors": "#db4c3c",
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

  });
