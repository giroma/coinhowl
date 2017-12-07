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

  // Flash Toast Alert
  var flashAlert = document.querySelector('.flash-alert')

  if ( flashAlert && flashAlert.innerText != null) {
    Materialize.toast(flashAlert, 4000);
  }// end of Flash Toast Alert

  // Get data from API for Search function
  var symbolHash = {}
  var myResults = function() {
    var url = "https://cors-anywhere.herokuapp.com/https://bittrex.com/api/v1.1/public/getmarkets";
    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'JSON'
    })
    .done(function(data) {
      data["result"].forEach(function(element) {
        var tempSymbol = element["MarketName"].includes('BTC-','');
        if (tempSymbol === true) {
          if (element["MarketName"] == 'BTC-BCC') {
            symbolHash['BCH Bitcoin Cash'] = "https://www.cryptocompare.com/media/1383919/bch.jpg"
          } else {
            var btcRemoved = element["MarketName"].replace('BTC-','');
            symbolHash[btcRemoved+' '+element["MarketCurrencyLong"]] = element["LogoUrl"]
          }
        }
    });

    $('input.autocomplete').autocomplete({
       data: symbolHash,
       limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
       onAutocomplete: function(val) {
         // Callback function when value is autcompleted.
             // select: function( event, ui ) {
               // var url = ui.item.label;
               window.location = '/coins/'+val.split(" ")[0];
             // },
       },
       minLength: 1 // The minimum length of the input for the autocomplete to start. Default: 1.
    });
        return symbolHash;
    });
  };

  // Start the searchCoinsTable
   function searchCoinsTable() {
     // Get input element
     var filterInput = document.getElementById('filterInput');
     // Add event listener
     filterInput.addEventListener('keyup', filterNames);

     function filterNames(){
       // Get value of input
       var filterValue = document.getElementById('filterInput').value.toUpperCase();

       // Get coins table
       var table = document.getElementById('coinsIndex');
       // Get td and tr from table
       var td = table.querySelectorAll('td.coin-title');
       var tr = table.querySelectorAll('tr.item');
       // Loop through collection-item tds
       for(var i = 0;i < tr.length;i++){
         var title = tr[i].getElementsByTagName('td')[0];
         // If matched
         if(title.innerHTML.toUpperCase().indexOf(filterValue) > -1){
           tr[i].style.display = '';
         } else {
           tr[i].style.display = 'none';
         }
       }

     }

   }// end of searchCoinsTable function

  myResults();

  if (document.getElementById('coinsIndex') != undefined) {
    searchCoinsTable();
  }
  // User logged in dropdown in navbar
  $(".dropdown-button").dropdown(
    { hover: true }
  );

  // Carousel timer
  $('.carousel').carousel();
  setInterval(function() {
    $('.carousel').carousel('next');
  }, 4000);

});
