// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener('DOMContentLoaded', function() {

  var followLink = document.getElementById('follow-coin');
  var unfollowLink = document.getElementById('unfollow-coin');
  var alertIcon = document.getElementById('alert')

  followLink.addEventListener('click', function(e) {
    e.preventDefault();
    $.ajax({
       url: e.target.getAttribute('href'),
       method: e.target.dataset.method,
       dataType: 'json'
     }).done(function(data) {
       followLink.classList.add('hide');
       unfollowLink.classList.remove('hide');
       alertIcon.classList.remove('hide');
       alertIcon.href = "/following/" + data.id + "/alerts";
     }).fail(function(data) {
       alert('Sorry, something went wrong, please try again!!!.')
     });
  });

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
       alert('!!!Sorry, something went wrong, please try again.')
     });
  });

});
