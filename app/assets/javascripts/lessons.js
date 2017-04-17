//= require comments

'use strict'

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Show Lesson

//------------------------------------------------------------------------
// Lesson Class

function Lesson(attributes) {
  this.id = attributes.lesson.id
  this.description = attributes.lesson.description
  this.content = attributes.lesson.content
  this.links = attributes.lesson.links
  this.created_at = Comment.format_date(new Date(attributes.lesson.created_at))
  this.category = attributes.lesson.category
  this.author = attributes.lesson.author
  this.can_update = attributes.lesson.can_update
  this.can_destroy = attributes.lesson.can_destroy

  this.comments = attributes.lesson.comments.reverse().map((comment) => new Comment({ comment: comment }))
}

// Instance methods

Lesson.prototype.appendToPage = function() {
  const html = Lesson.template(this)
  $(".lesson-container").append(html)
}

// Class methods

Lesson.ready = function() {
  if($("#lesson-template").length <= 0) return;

  let source = $("#lesson-template").html()
  Lesson.template = Handlebars.compile(source)

  Lesson.loadLesson()
}

Lesson.loadLesson = function() {
  $(".loading").show()
  $.ajax({
    url: window.location.href,
    type: "GET",
    dataType: "json"
  })
  .done(Lesson.successLoad)
  .fail(Lesson.failLoad)
}

Lesson.successLoad = function(json) {
  const lesson = new Lesson(json)

  $(".loading").hide()
  lesson.appendToPage()
  Comment.appendToPage(lesson)
}

Lesson.failLoad = function(xhr) {
  let error
  switch(xhr.readyState) {
    case 0:
      error = "Network Error"
    case 4:
      if(Math.floor((xhr.status/100)) === 5) { // Status Code 5**
        error = "Server Error"
      } else {
        error = xhr.responseText
      }
    default:
      error = "Error occured"
  }

  $("#lesson-error").text(error)
}


$(document).ready(function() {
  Lesson.ready()
})


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Index Ation

function attachListeners() {
  $(".category-li").on("click", slideLessons)
}

function slideLessons() {
  $(this).find(".category-lessons").slideToggle()
}

$(document).ready(function() {
  attachListeners()
})
