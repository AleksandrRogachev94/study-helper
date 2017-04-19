function Request(attributes) {
  let prop
  for(prop in attributes.request) {
    this[prop] = attributes.request[prop]
  }
}

Request.loadRequests = function(ev) {
  ev.preventDefault()
  $.ajax({
    url: $(this).attr("href"),
    type: "GET",
    dataType: "json"
  })
  .done(Request.successLoad)
  .fail(Request.failLoad)
}

Request.successLoad = function(json) {
  const requests = json.requests.reverse().map((request) => new Request({ request: request }))
  console.log(requests)
  Request.appendToPage(requests)
}

Request.failLoad = function(xhr) {
  let error
  switch(xhr.readyState) {
    case 0:
      error = "Network Error"
      break
    case 4:
      if(Math.floor((xhr.status/100)) === 5) { // Status Code 5**
        error = "Server Error"
        break
      } else {
        error = $.parseJSON(xhr.responseText).errors.join(", ")
        break
      }
    default:
      error = "Error occured"
  }
  $(".requests-error").text(error)// Place Error
}

Request.appendToPage = function(requests) {
  const html = Request.indexTemplate(requests)
  const $wrapper = $("#new-requests")
  $wrapper.slideUp(800, function() {
    $wrapper.empty()
    if($wrapper.is(':visible')) $wrapper.hide()
    $(html).appendTo($wrapper)
    $wrapper.slideDown(800)
  })
}
