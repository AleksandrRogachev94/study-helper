//= require requests

$(document).ready(function() {
  if($("#request-partial").length <= 0 || $("#requests-template").length <= 0) return;
  $(".loader").hide()

  let source = $("#requests-template").html()
  Request.indexTemplate = Handlebars.compile(source)
  // $(".loader").hide()

  Handlebars.registerPartial('requestPartial',  document.getElementById("request-partial").innerHTML)
  $(".load-requests").on("click", Request.loadRequests)
  // $(".load-requests").on("click", Request.loadRequests)
})
