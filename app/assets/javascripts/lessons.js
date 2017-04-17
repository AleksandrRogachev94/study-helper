//= require comments

//--------------------------------------------------------
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
