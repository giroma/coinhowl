// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

  if (!Cookies.get('currency')) { //set currency cookie to USD as default if none exists
    Cookies.set('currency', 'USD');
  }

  var btcPrice = document.querySelector('.btc-price') //select btc price display element in header
  btcPrice.addEventListener('click', function () { //toggle user cookie currency preference to USD to CAD to EUR
    if (Cookies.get('currency') === 'USD'){
      Cookies.set('currency', 'CAD')
      btcPrice.innerText = 'CAD'
    }
    else if (Cookies.get('currency') === 'CAD'){
      Cookies.set('currency', 'EUR')
      btcPrice.innerText = 'EUR'
    }
    else {
      Cookies.set('currency', 'USD')
      btcPrice.innerText = 'USD'
    }
  })
  //update main index price data every 3 seconds
  setInterval(function () {
    // var coinSymbol = $('.js-coin-symbol').text() //get coin name from html element
    $.ajax({
      url: "https://cors.now.sh/https://bittrex.com/api/v1.1/public/getmarketsummaries",
      method: 'GET'
    })
    .done(function (response) {
      var items = document.querySelectorAll('tbody .item');
      items.forEach(function (item) { // iterate over each .item/coin in the html index table
        var coinName = item.querySelector('.coin-symbol').innerText; //get coin name from td tag value
        var apiCoin = response['result'].find(function (coin) { //return coin data from api matching coinName from current html row
          if (coinName === 'BTC-BCH') {
          return coin['MarketName'] === 'BTC-BCC';
          }
          else {
          return coin['MarketName'] === coinName;
          }
        });
        if ( item.style.display !== 'none') {// When filtering checks their property isn't display:none
          item.querySelector('.coin-volume').innerText = (apiCoin['BaseVolume'].toFixed(3)) //update volume
          item.querySelector('.coin-last').innerText = (apiCoin['Last'].toFixed(8))       //update last price
        }
      });
    });
    //update BTC price with live data in the header
    var cookie = Cookies.get('currency')

    $.ajax({
      url:"https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,CAD,EUR",
      method: 'GET'
    }).done(function (response) {
      $('.btc-price').text(`1ɃTC = ${response[cookie].toFixed(2)} ${cookie}`)
    })
  },3000);
});
