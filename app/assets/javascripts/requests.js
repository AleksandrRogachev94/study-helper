function Request(attributes) {
  let prop
  for(prop in attributes.request) {
    this[prop] = attributes.request[prop]
  }
}

Request.prototype.destroy = function(accepted = false) {
  if(accepted) {
    const html = Request.template(this)
    $(html).hide().appendTo($())
    $wrapper.slideDown(800)
  }

  $("li#request_" + this.id).fadeOut("normal", function() {
    $(this).remove();
  });
}


//---------------------------------------------------------------
// Index Action

Request.loadRequests = function(ev) {
  ev.preventDefault()
  $(".loader").show()
  $.ajax({
    url: $(this).attr("href"),
    type: "GET",
    dataType: "json"
  })
  .done(Request.successLoad)
  .fail(Request.failLoad)
  .always(() => { $(".loader").hide() })
}

Request.successLoad = function(json) {
  if(json.notice) {
    $(".no-requests").text(json.notice)
    return;
  }

  const requests = json.requests.reverse().map((request) => new Request({ request: request }))
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
      }
    default:
      error = "Error occured"
  }
  $(".requests-error").text(error) // Place Error
}

Request.appendToPage = function(requests) {
  const html = Request.indexTemplate(requests)
  const $wrapper = $("#new-requests")
  $(".requests-error, .no-request").text("")
  $wrapper.slideUp(800, function() {
    $wrapper.empty()
    if($wrapper.is(':visible')) $wrapper.hide()
    $(html).appendTo($wrapper)
    $wrapper.slideDown(800)
  })
}

//-------------------------------------------------------
// Accept/Decline

Request.acceptRequest = function(ev) {
  ev.preventDefault()
  Request.SubmitFormAJAX($(this), Request.successCloseRequest.bind($(this)), Request.failCloseRequest.bind($(this)))
}

Request.declineRequest = function(ev) {
  ev.preventDefault()
  Request.SubmitFormAJAX($(this), Request.successCloseRequest.bind($(this)), Request.failCloseRequest.bind($(this)))
}

Request.successCloseRequest = function(json) {
  const request = new Request(json)
  request.destroy($(this).hasClass("accept"))
}

Request.failCloseRequest = function(xhr) {
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
  this.parent().children().last().text(error) // Place Error
}

Request.SubmitFormAJAX = function($form, success, fail) {
  $.ajax({
    url: $form.attr("action"),
    type: ($form.find("input[name='_method']").val() || $form.attr("method")),
    data: $form.serialize(),
    dataType: "json"
  })
  .done(success)
  .fail(fail)
}
