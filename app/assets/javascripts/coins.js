document.addEventListener('DOMContentLoaded', function({
  $(document).ready(function() {
    $('.follow_coin').click(function() {
      $.ajax({
        url: '<%= following_path %>',
        type: 'PUT',
        success: function(result) {
          alert("Followed")
        }
      });
    });
  })
});
