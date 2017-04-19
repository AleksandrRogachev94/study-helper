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
  console.log(xhr)
}

Request.appendToPage = function(requests) {
  const html = Request.indexTemplate(requests)
  // const $wrapper = $(".lesson-container")

  // if($wrapper.is(':visible')) $wrapper.hide()
  $(html).appendTo($("#new-requests"))
  // $wrapper.slideDown(1000)
}
