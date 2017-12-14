// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

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
        item.querySelector('.coin-volume').innerText = (apiCoin['BaseVolume'].toFixed(3)) //update volume
        item.querySelector('.coin-last').innerText = (apiCoin['Last'].toFixed(8))       //update last price
      });
    });
  },3000);
});
