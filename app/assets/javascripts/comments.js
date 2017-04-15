//------------------------------------------------------------------------
// Comment Class

function Comment(attributes) {
  this.id = attributes.id
  this.content = attributes.content
  this.created_at = attributes.created_at
  this.author = attributes.author
}

// Instance methods

Comment.prototype.renderLI = function() {
  return Comment.template(this)
}

// Class methods

Comment.ready = function() {
  let source = $("#comment-template").html()
  Comment.template = Handlebars.compile(source)
  Comment.attachListeners()
}

Comment.attachListeners = function() {
  $("#new_comment").on("submit", Comment.formSubmit)
}

Comment.formSubmit = function(ev) {
  ev.preventDefault()
  const $form = $(this)

  const params = $form.serialize()
  const action = $form.attr("action")

  $.ajax({
    url: action,
    type: "POST",
    data: params,
    dataType: "json"
  })
  .done(Comment.successCreate)
  .fail(Comment.failCreate)
}

Comment.successCreate = function(json) {
  $.rails.enableFormElements($("#new_comment"))

  const comment = new Comment(json)

  $("#comment-error").text("") // Empty error div
  $("#comments").prepend(comment.renderLI())
}

Comment.failCreate = function(xhr) {
  $.rails.enableFormElements($("#new_comment"))

  let error
  switch(xhr.readyState) {
    case 0:
      error = "Network Error"
      break
    case 4:
      error = $.parseJSON(xhr.responseText).errors.join(", ")
      break
    default:
      error = "Error occured"
  }

  $("#comment-error").text(error)
}

//------------------------------------------------------------------------
// Documents Ready

$(document).ready(function() {
  Comment.ready()
})
