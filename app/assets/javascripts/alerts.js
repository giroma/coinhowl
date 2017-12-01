// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  // $('.modal-trigger').leanModal();
   $('.modal').modal();
//
//     var alert = document.getElementById('alert')
//
//     alert.addEventListener('click', function(e) {
//       e.preventDefault();
//       $.ajax({
//          url: e.target.getAttribute('href'),
//          method: e.target.dataset.method,
//          dataType: 'json'
//        }).done(function(data) {
//          alert('Alert successfully created.')
//        }).fail(function(data) {
//          alert('Sorry, something went wrong, please try again.')
//        });
//     });
//


//   $("a[data-remote]").on("ajax:success", (e, data, status, xhr) => alert("The alert was deleted."))
// });

$('.delete_alert').bind('ajax:success', function() {
        $(this).closest('tr').fadeOut();
});
});
