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
//= require materialize
//= require coins
//= require alerts
//= require jquery-ui
//= require_tree .
//= stub coins

$(document).ready(function() {
var trig = 1;
//fix for chrome
$("#search").addClass('searchbarfix');


  //animate searchbar width increase to  +150%
  $('#search').click(function(e) {
       //handle other nav elements visibility here to avoid push down
    $('.search-hide').addClass('hide');
   if (trig == 1){
      $('#navfix2').animate({
        width: '+=150',
        marginRight: 0
      }, 400);

     trig ++;
     }

  });

  // if user leaves the form the width will go back to original state

  $("#search").focusout(function() {

      $('#navfix2').animate({
      width: '-=150'
    }, 400);
   trig = trig - 1;
    //handle other nav elements visibility first to avoid push down
    $('.search-hide').removeClass('hide');

  });

  var symbolArray = []
  var url = "https://cors-anywhere.herokuapp.com/https://bittrex.com/api/v1.1/public/getmarketsummaries";
  $.ajax({
  url: url,
  method: 'GET',
  dataType: 'JSON'
  }).done(function(data){
  data["result"].forEach(function(element) {
    // var tempSymbol = element["MarketName"];
    var tempSymbol = element["MarketName"].includes('BTC-','');
    if(tempSymbol == true) {
      var btcRemoved = element["MarketName"].replace('BTC-','');
      symbolArray.push(btcRemoved);
    }
});
  return symbolArray
});


  $(function() {
    $('input.autocomplete').autocomplete({
      select: function( event, ui ) {
        var url = ui.item.label;
        window.location = '/coins/'+url
      },
      source: symbolArray
    });
  });

});
