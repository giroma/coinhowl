// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener("DOMContentLoaded", function(event) {

  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  // $('.modal-trigger').leanModal();
   $('.modal').modal();

   var newAlertForm = document.querySelector('#new_alert');

  newAlertForm.addEventListener('submit', function (e) {
    e.preventDefault()

    $.ajax({
      url: newAlertForm.getAttribute('action'),
      method: newAlertForm.getAttribute('method'),
      dataType: 'json',
      data: $(newAlertForm).serialize()
    }).done(function (response) {
      newAlertForm.reset()
      $('.alerts-table').prepend(
        `<tr class="alerts-info">
          <td>${response.price_above}</td>
          <td>${response.price_below}</td>
          <td>${response.percent}</td>
          <td>${response.state}</td>
          <td></td>
        </tr>`)

        //   <%= alert.price_above %></td>
        // <td><%= alert.price_below %></td>
        // <td><%= alert.percent %>%</td>
        // <td><%= alert.state %></td>
        // <% if alert.state == "Active" %>
        // <td><p><%= alert.state %>&nbsp;<%= image_tag("active-alert", size: "20x20") %></p></td>
        // <% elsif alert.state == "Inactive" %>
        // <td><p><%= alert.state %>&nbsp;<%= image_tag("inactive-alert", size: "20x20") %></p></td>
        // <% end %>
        // <td>

      setTimeout(function(){
        $('#create-alert').removeAttr('disabled')
        // $('#tweet_message').focus()
      }, 1)
    })
  })



   // portfolio list of alerts delete method
   $('.delete_alert').bind('ajax:success', function() {
    var alertCount = $(this).closest('.active')[0].childNodes[1].childNodes[4].nextSibling.childNodes[1].childNodes[2];
    var alertWolf = $(this).closest('.active')[0].childNodes[1].childNodes[4].nextSibling.childNodes[1]
          $(this).closest('tr').fadeOut();
          alertCount.innerText -= 1;
          if (alertCount.innerText === "0") {
            alertWolf.innerText = "";
          }
  });
});
