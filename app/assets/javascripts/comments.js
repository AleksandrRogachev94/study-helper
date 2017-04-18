'use strict'

//------------------------------------------------------------------------
// Comment Class

function Comment(attributes) {
  this.id = attributes.comment.id
  this.content = attributes.comment.content
  this.created_at = Comment.format_date(new Date(attributes.comment.created_at))
  this.author = attributes.comment.author
  this.can_update = attributes.comment.can_update
  this.can_destroy = attributes.comment.can_destroy
}

// Instance methods

Comment.prototype.render = function() {
  const li = Comment.template(this)
  const rendered = $(li).prependTo("#comments").hide()
  rendered.slideDown()
}

Comment.prototype.replaceContentWithForm = function($content) {
  const form = Comment.updateTemplate(this)
  $content.replaceWith(form)
}

Comment.prototype.replaceFormWithContent = function($form) {
  const content = '<p class="content">' + this.content + '</p>'
  $form.replaceWith(content)
}

Comment.prototype.destroy = function() {
  $("li#comment_" + this.id).fadeOut("normal", function() {
    $(this).remove();
  });
}

// Class methods

Comment.ready = function() {
  Comment.commentsToUpdate = [] // Array for all comments opened to update.

  if($("#comment-partial").length <= 0 || $("#update-comment-template").length <= 0 || $("#comments-template").length <= 0) return;
  Comment.prepareHandlebars()

  Comment.attachListeners()
}

Comment.prepareHandlebars = function() {
  let source = $("#comments-template").html()
  Comment.commentsTemplate = Handlebars.compile(source)

  source = $("#comment-partial").html()
  Comment.template = Handlebars.compile(source)
  Handlebars.registerPartial('commentPartial',  document.getElementById("comment-partial").innerHTML)

  source = $("#update-comment-template").html()
  Comment.updateTemplate = Handlebars.compile(source)
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
  comment.replaceContentWithForm($(this).parent().parent().parent().next())
  $("#comment_" + id + " .form-update-comment textarea").focus()
}

Comment.from_li = function(id) {
  let $li = $("li#comment_" + id)
  if($li.length <= 0) return new Comment({});

  const json = {
    comment: {
      id: id,
      content: $li.find(".content").text(),
      created_at: $li.find(".created_at").text(),
      author: {
        appearance: $li.find(".appearance").text(),
        avatar_url: $li.find(".avatar-comment").css("background-image")
      }
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
  comment.replaceFormWithContent(this)
}

Comment.failUpdate = function(xhr) {

  let error = Comment.processError(xhr)

  // 'this' binded to form
  const id = this.parent().data("id")
  const comment = Comment.removeFromCommentsToUpdate(id) // Remove from array of opened comments
  comment.replaceFormWithContent(this)
  $("#comment_" + id + " .comment-error").text(error) // Place Errors.
}

Comment.cancelUpdate = function(ev) {
  ev.preventDefault()
  // 'this' binded to form
  const id = $(this).parent().parent().data("id")
  const comment = Comment.removeFromCommentsToUpdate(id) // Remove from array of opened comments
  comment.replaceFormWithContent($(this).parent())
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
// Index Action

Comment.appendToPage = function(lesson) {
  const html = Comment.commentsTemplate(lesson)
  const rendered = $(html).appendTo(".lesson-container")
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
