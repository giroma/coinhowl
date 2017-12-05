// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener('DOMContentLoaded', function() {

  var followLink = document.getElementById('follow-coin');
  var unfollowLink = document.getElementById('unfollow-coin');
  // We should remove the next line, the button won't be in the page untill the follow button is pressed, so defining it now will result in undefined
  var alertIcon = document.getElementById('alert-icon');
  var alertForm = document.querySelector('.alert-form')

  // Add if statement to avoid getting error in all other pages that do not have follow/unfollow Link
  if (followLink != undefined) {
    followLink.addEventListener('click', function(e) {
      e.preventDefault();
      $.ajax({
         url: e.target.getAttribute('href'),
         method: e.target.dataset.method,
         dataType: 'json'
       }).done(function(data) {
         // Define alert icon inside the function, once the button has been pressed, otherwise it doesn't have it defined yet.
         followLink.classList.add('hide');
         unfollowLink.classList.remove('hide');
         alertIcon.classList.remove('hide');
         var array = this.url.split("/");
         var followingCode = this.url.split("/")[array.length-1]
         populate_alert_form(followingCode);
       }).fail(function(data) {
       });
    });
}
  // Add if statement to avoid getting error in all other pages that do not have follow/unfollow Link
  if (unfollowLink != undefined) {
    unfollowLink.addEventListener('click', function(e) {
      e.preventDefault();
      $.ajax({
         url: e.target.getAttribute('href'),
         method: e.target.dataset.method,
         dataType: 'json'
       }).done(function(data) {
         unfollowLink.classList.add('hide');
         followLink.classList.remove('hide');
         alertIcon.classList.add('hide');
       }).fail(function(data) {
       });
    });
}
  function populate_alert_form(followingCode) {
    $.ajax ({
      url: '/following/' + followingCode + '/alert_form',
      method: 'GET',
      dataType: 'html',
    }).done(function(html) {
      alertForm.innerHTML = html;
    });
  };

});
