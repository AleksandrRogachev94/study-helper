'use strict'

//------------------------------------------------------------------------
// Comment Class

function Comment(attributes) {
  this.id = attributes.id
  this.content = attributes.content
  this.created_at = Comment.format_date(new Date(attributes.created_at))
  this.author = attributes.author
}

// Instance methods

Comment.prototype.render = function() {
  const li = Comment.template(this)
  const rendered = $(li).prependTo("#comments").hide()
  rendered.slideDown()
}

Comment.prototype.replaceCommentWithForm = function($li) {
  const form = Comment.updateTemplate(this)
  $li.replaceWith(form)
}

Comment.prototype.replaceFormWithComment = function($form) {
  const li = Comment.template(this)
  $form.replaceWith(li)
}

Comment.prototype.destroy = function() {
  $("li#comment_" + this.id).fadeOut("normal", function() {
    $(this).remove();
  });
}

// Class methods

Comment.ready = function() {
  Comment.commentsToUpdate = [] // Array for all comments opened to update.
  // Comment.fixDates() // Fix dates from the server.

  if($("#comment-template").length <= 0 || $("#update-comment-template").length <= 0) return;

  let source = $("#comment-template").html()
  Comment.template = Handlebars.compile(source)

  source = $("#update-comment-template").html()
  Comment.updateTemplate = Handlebars.compile(source)

  Comment.attachListeners()
}

Comment.attachListeners = function() {
  // $("#new_comment").on("submit", Comment.formSubmit)
  // $("#comments").on("submit", ".delete-comment", Comment.destroy)
  //
  // $("#comments").on("click", ".update-comment", Comment.addUpdateForm)
  // $("#comments").on("submit", ".form-update-comment", Comment.update)
  // $("#comments").on("click", "#cancel-update-comment", Comment.cancelUpdate)

  $(document).on("submit", "#new_comment", Comment.formSubmit)
  $(document).on("submit", ".delete-comment", Comment.destroy)

  $(document).on("click", ".update-comment", Comment.addUpdateForm)
  $(document).on("submit", ".form-update-comment", Comment.update)
  $(document).on("click", "#cancel-update-comment", Comment.cancelUpdate)
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Create comment

Comment.formSubmit = function(ev) {
  ev.preventDefault()
  const $form = $(this)

  Comment.SubmitFormAJAX($form, Comment.successCreate, Comment.failCreate)
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

  let error = Comment.processError(xhr)
  $("#create-comment-error").text(error)
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Delete comment

Comment.destroy = function(ev) {
  ev.preventDefault()

  const $form = $(this)
  if(!Comment.confirmDestroy($form)) return;

  Comment.SubmitFormAJAX($form, Comment.successDestroy, Comment.failDestroy.bind($form))
}

Comment.confirmDestroy = function($form) {
  if(!confirm("Are you sure?")) {
    setTimeout(function() { $.rails.enableFormElements($form) }, 100) // Preventing disabling of a button
    return false;
  }
  return true
}

Comment.successDestroy = function(json) {
  const comment = new Comment(json)
  comment.destroy()
}

Comment.failDestroy = function(xhr) {
  let error = Comment.processError(xhr)

  // 'this' binded to form
  this.parent().parent().parent().next().next().text(error) // Place Errors.
}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Update comment

Comment.addUpdateForm = function(ev) {
  ev.preventDefault()
  const id = $(this).data("id")

  const comment = Comment.from_li(id)
  Comment.commentsToUpdate.push(comment) // Add to array of comments opened to update.
  comment.replaceCommentWithForm($(this).parent().parent().parent().next())
  $("#comment_" + id + " .form-update-comment textarea").focus()
}

Comment.from_li = function(id) {
  let $li = $("li#comment_" + id)
  if($li.length <= 0) return new Comment({});

  const json = {
    id: id,
    content: $li.find(".content").text(),
    created_at: $li.find(".created_at").text(),
    author: {
      appearance: $li.find(".appearance").text()
    }
  }

  return new Comment(json)
}

Comment.update = function(ev) {
  ev.preventDefault()

  const $form = $(this)
  Comment.SubmitFormAJAX($form, Comment.successUpdate.bind($form), Comment.failUpdate.bind($form))
}

Comment.successUpdate = function(json) {
  const comment = new Comment(json)

  // 'this' binded to form
  Comment.removeFromCommentsToUpdate(comment.id)
  comment.replaceFormWithComment(this.parent().parent())
}

Comment.failUpdate = function(xhr) {

  let error = Comment.processError(xhr)

  // 'this' binded to form
  const id = this.parent().data("id")
  const comment = Comment.removeFromCommentsToUpdate(id) // Remove from array of opened comments
  comment.replaceFormWithComment(this.parent().parent())
  $("#comment_" + id + " .comment-error").text(error) // Place Errors.
}

Comment.cancelUpdate = function(ev) {
  ev.preventDefault()
  console.log("Hijacked")
  // 'this' binded to form
  const id = $(this).parent().parent().data("id")
  const comment = Comment.removeFromCommentsToUpdate(id) // Remove from array of opened comments
  comment.replaceFormWithComment($(this).parent().parent().parent())
}

Comment.removeFromCommentsToUpdate = function(id) {
  let array = Comment.commentsToUpdate
  let i, l = array.length
  for(i = 0; i < l; i++) {

    if(array[i].id === id) {
      Comment.commentsToUpdate = [...array.slice(0, i), ...array.slice(i + 1)]
      return array[i]
    }
  }
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Shared methods.

Comment.processError = function(xhr) {
  switch(xhr.readyState) {
    case 0:
      return "Network Error"
    case 4:
      if(Math.floor((xhr.status/100)) === 5) { // Status Code 5**
        return "Server Error"
      } else {
        return $.parseJSON(xhr.responseText).errors.join(", ")
      }
    default:
      return "Error occured"
  }
}

Comment.SubmitFormAJAX = function($form, success, fail) {
  console.log(($form.find("input[name='_method']").val() || $form.attr("method")))
  $.ajax({
    url: $form.attr("action"),
    type: ($form.find("input[name='_method']").val() || $form.attr("method")),
    data: $form.serialize(),
    dataType: "json"
  })
  .done(success)
  .fail(fail)
}

Comment.fixDates = function() {
  let js_date
  const dates = $(".created_at")

  dates.each(function() {
    js_date = new Date($(this).text())
    $(this).text(Comment.format_date(js_date))
  })
}

var month = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

Comment.format_date = function(date) {
  return `${month[date.getMonth()]} ${date.getDate()}, ${date.getFullYear()}`
}

//------------------------------------------------------------------------
// Documents Ready

$(document).ready(function() {
  Comment.ready()
})
