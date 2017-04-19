//= require requests

$(document).ready(function() {
  if($("#request-partial").length <= 0 || $("#requests-template").length <= 0) return;
  $(".loader").hide()

  let source = $("#requests-template").html()
  Request.indexTemplate = Handlebars.compile(source)
  source = $("#request-partial").html()
  Request.template = Handlebars.compile(source)
  source = $("#student-template").html()
  Request.studentTemplate = Handlebars.compile(source)
  Handlebars.registerPartial('requestPartial',  document.getElementById("request-partial").innerHTML)

  $(".load-requests").on("click", Request.loadRequests)
  $(document).on("submit", ".accept", Request.acceptRequest)
  $(document).on("submit", ".decline", Request.declineRequest)
  $(document).on("submit", ".remove-student", removeStudent)
})

function removeStudent(ev) {
  ev.preventDefault()
  const $form = $(this)
  if(!confirmRemove($form)) return;

  $.ajax({
    url: $form.attr("action"),
    type: ($form.find("input[name='_method']").val() || $form.attr("method")),
    data: $form.serialize(),
    dataType: "json"
  })
  .done(successRemove.bind($form))
  .fail(failRemove.bind($form))
}

function confirmRemove($form) {
  if(!confirm("Are you sure?")) {
    setTimeout(function() { $.rails.enableFormElements($form) }, 100) // Preventing disabling of a button
    return false;
  }
  return true
}

function successRemove(json) {
  console.log(json)
  this.parent().fadeOut("normal", function() {
    this.remove();
  })
}

function failRemove(xhr) {
  setTimeout(() => { $.rails.enableFormElements(this) }, 100) // Preventing disabling of a button
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
  this.parent().find(".student-error").text(error) // Place Error
}
