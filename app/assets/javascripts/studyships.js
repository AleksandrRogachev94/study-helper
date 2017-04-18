//= require requests

$(document).ready(function() {
  $(".load-requests").on("click", function(ev) {
    ev.preventDefault()
    console.log("Hijacked")
  })
})
