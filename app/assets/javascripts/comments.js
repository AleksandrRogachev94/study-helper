$(document).ready(function() {
  $("#new_comment").on("submit", function(ev) {
    ev.preventDefault()
    let $form = $(this)

    let params = $form.serialize()
    let action = $form.attr("action")

    $.ajax({
      url: action,
      type: "POST",
      data: params,
      dataType: "json"
    })
    .done(function(json) {
      $.rails.enableFormElements($form)
      console.log(json)
    })
    .fail(function(error) {
      $.rails.enableFormElements($form)
      console.log(error)
    })

    $.rails.enableFormElements($form)
    // $.rails.enableFormElements($("#new_comment"))
  })

})
