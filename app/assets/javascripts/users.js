//= require lessons
//= require profiles

$(document).ready(function() {
  if($("#lessons-by-categories-template").length <= 0) return;
  $(".loader").hide()

  let source = $("#lessons-by-categories-template").html()
  Lesson.lessonByCategoriesTemplate = Handlebars.compile(source)

  $("#user-lessons-link").on("click", Lesson.loadUserLessons)
  $(".edit-profile").on("click", Profile.prepareAndRenderForm)
})
