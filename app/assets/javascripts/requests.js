function Request(attributes) {
  let prop
  for(prop in attributes.request) {
    this[prop] = attributes.request[prop]
  }
}

Request.ready = function() {
  if($("#request-template").length <= 0) return;

  let source = $("#request-template").html()
  Request.template = Handlebars.compile(source)
}

$(document).ready(function() {
  Request.ready()
})
