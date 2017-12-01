// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  // $('.modal-trigger').leanModal();
   $('.modal').modal();

  var alertCount = document.querySelector('.alert-count');
  var alertWolf = document.querySelector('#wolf-alert');

  $('.delete_alert').bind('ajax:success', function() {
          $(this).closest('tr').fadeOut();
          alertCount.innerText -= 1;
          if (alertCount.innerText === "0") {
            alertWolf.innerText = "";
          }
  });
});
