//= require requests

$(document).ready(function() {
  if($("#request-partial").length <= 0 || $("#requests-template").length <= 0) return;
  $(".loader").hide()

  let source = $("#requests-template").html()
  Request.indexTemplate = Handlebars.compile(source)

  source = $("#request-partial").html()
  Request.template = Handlebars.compile(source)

  Handlebars.registerPartial('requestPartial',  document.getElementById("request-partial").innerHTML)
  $(".load-requests").on("click", Request.loadRequests)
  $(document).on("submit", ".accept", Request.acceptRequest)
  $(document).on("submit", ".decline", Request.declineRequest)
})
