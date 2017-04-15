function Comment(attributes) {
  this.id = attributes.id
  this.content = attributes.content
  this.created_at = attributes.created_at
  this.author = attributes.author
}

Comment.prototype.renderLI = function() {
  return Comment.template(this)
}

$(document).ready(function() {
  let source = $("#comment-template").html()
  Comment.template = Handlebars.compile(source)
})

//------------------------------------------------------
// Documents Ready

$(document).ready(function() {
  $("#new_comment").on("submit", function(ev) {
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
    .done(function(json) {
      $.rails.enableFormElements($form)
      const comment = new Comment(json)

      $("#comment-error").text("") // Empty error div
      $("#comments").prepend(comment.renderLI())
    })
    .fail(function(xhr) {
      $.rails.enableFormElements($form)
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
    })
  })

})
