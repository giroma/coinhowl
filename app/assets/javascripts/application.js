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
  $('.carousel.carousel-slider').carousel({fullWidth: true});
  // $('.carousel-slider').slider({full_width: true});//slider init


var symbolHash = {}
var myResults = function() {
  var url = "https://cors-anywhere.herokuapp.com/https://bittrex.com/api/v1.1/public/getmarketsummaries";
  $.ajax({
  url: url,
  method: 'GET',
  dataType: 'JSON'
  }).done(function(data){
      data["result"].forEach(function(element) {
        var tempSymbol = element["MarketName"].includes('BTC-','');
          if(tempSymbol == true) {
            var btcRemoved = element["MarketName"].replace('BTC-','');
            symbolHash[btcRemoved] = null
          }
      });
      console.log(symbolHash);

      $('input.autocomplete').autocomplete({
       data: symbolHash,
       limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
       onAutocomplete: function(val) {
         console.log(val);
         // Callback function when value is autcompleted.
             // select: function( event, ui ) {
               // var url = ui.item.label;
               window.location = '/coins/'+val
             // },
       },
       minLength: 1, // The minimum length of the input for the autocomplete to start. Default: 1.
      });


      return symbolHash;
  });
};
myResults();



  // $(function() {
  //   $('input.autocomplete').autocomplete({
  //     select: function( event, ui ) {
  //       var url = ui.item.label;
  //       window.location = '/coins/'+url
  //     },
  //     source: symbolArray
  //   });
  // });


$(".dropdown-button").dropdown(
  { hover: true }
);

});
