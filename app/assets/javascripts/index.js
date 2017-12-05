// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

  //update main index price data every 3 seconds
  setInterval(function () {
    // var coinSymbol = $('.js-coin-symbol').text() //get coin name from html element

    $.ajax({
      url: "https://cors-anywhere.herokuapp.com/https://bittrex.com/api/v1.1/public/getmarketsummaries",
      method: 'GET'
    }).done(function (response) {
      $('tbody .item').each(function () { // itterate over each .item/coin in the html index table
        var coinName = $(this).find('td').eq(1).text() //get coin name from td tag value
        var apiCoin = response['result'].find(function (coin) { //return coin data from api matching coinName from current html row
          return coin['MarketName'] === coinName
        })
        $(this).find('td').eq(2).html(apiCoin['BaseVolume'].toFixed(3)) //update volume
        $(this).find('td').eq(4).html(apiCoin['Last'].toFixed(8))       //update last price
      })
    })
  },3000)
});
