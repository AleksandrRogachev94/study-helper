'use strict'

//------------------------------------------------------------------------
// Comment Class

function Comment(attributes) {
  this.id = attributes.id
  this.content = attributes.content
  this.created_at = attributes.created_at
  this.author = attributes.author
}

// Instance methods

Comment.prototype.render = function() {
  const li = Comment.template(this)
  $("#comments").prepend(li)
}

Comment.prototype.destroy = function() {
  $("li#comment_" + this.id).remove()
}

// Class methods

Comment.ready = function() {
  let source = $("#comment-template").html()
  Comment.template = Handlebars.compile(source)
  Comment.attachListeners()
}

Comment.attachListeners = function() {
  $("#new_comment").on("submit", Comment.formSubmit)
  $("#comments").on("submit", ".delete-comment", Comment.destroy)
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

  $("#new_comment textarea").val("")// Empty input
  $("#create-comment-error").text("") // Empty error div
  comment.render() // Adding to the page
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

  $("#create-comment-error").text(error)
}

Comment.destroy = function(ev) {
  ev.preventDefault()

  const $form = $(this)
  if(!Comment.confirmDestroy($form)) return;

  const params = $form.serialize()
  const action = $form.attr("action")

  $.ajax({
    url: action,
    type: "DELETE",
    data: params,
    dataType: "json"
  })
  .done(Comment.successDestroy)
  .fail(Comment.failDestroy.bind($form))
}

Comment.confirmDestroy = function($form) {
  if(!confirm("Are you sure?")) {
    setTimeout(function() { $.rails.enableFormElements($form) }, 100) // Preventing disabling of a button
    return false;
  }
  return true
}

Comment.successDestroy = function(json) {
  // debugger
  const comment = new Comment(json)
  comment.destroy()
}

Comment.failDestroy = function(xhr) {
  let error
  switch(xhr.readyState) {
    case 0:
      error = "Network Error"
      break
    default:
      error = "Error occured"
  }
  // this binded to form
  this.parent().next().text(error)
}

//------------------------------------------------------------------------
// Documents Ready

$(document).ready(function() {
  Comment.ready()
})
