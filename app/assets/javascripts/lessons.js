//= require comments

'use strict'

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Show Lesson

//------------------------------------------------------------------------
// Lesson Class

function Lesson(attributes) {
  this.id = attributes.id
  this.description = attributes.description
  this.content = attributes.content
  this.links = attributes.links
  this.created_at = Comment.format_date(new Date(attributes.created_at))
}

Lesson.ready = function() {
  Lesson.loadLesson()
}

Lesson.loadLesson = function() {
  $.ajax({
    url: window.location.href,
    type: "GET",
    dataType: "json"
  })
  .done(Lesson.successLoad)
  .fail(Lesson.failLoad)
}

Lesson.successLoad = function(json) {
  debugger
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
  //xxx
  console.log(error)
}


$(document).ready(function() {
  Lesson.ready()
})


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// Index

function attachListeners() {
  $(".category-li").on("click", slideLessons)
}

function slideLessons() {
  $(this).find(".category-lessons").slideToggle()
}

$(document).ready(function() {
  attachListeners()
})
