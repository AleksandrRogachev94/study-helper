function Profile(attributes) {
  let prop

  for(prop in attributes.profile) {
    this[prop] = attributes.profile[prop]
  }

  for(prop in this.properties) {
    if(!this.properties[prop]) delete this.properties[prop]
  }
}

Profile.prepareAndRenderForm = function(ev) {
  ev.preventDefault()
  Profile.get()
    .done(json => {
      const profile = new Profile(json)
      profile.renderForm(json)
      $("#modal-form").modal()
    })
    .fail(Profile.failLoad)
}

Profile.get = function() {
  return $.ajax({
    url: "/profile",
    type: "GET",
    dataType: "json"
  })
}

Profile.failLoad = function(xhr) {
  const errors = Profile.processError(xhr)
  $("#profile-load-error").text(errors)
}

Profile.prototype.renderForm = function() {
  $("#profile-form").append(Profile.formTemplate(this))
  $("form.edit_profile").on("submit", Profile.update)
}

Profile.update = function(ev) {
  ev.preventDefault()
  Profile.submitFormAJAX($(this), Profile.successUpdate, Profile.failUpdate.bind($(this)))
}

Profile.successUpdate = function(json) {
  $("#modal-form").modal('hide')
  const profile = new Profile(json)
  profile.render()
}

Profile.prototype.render = function() {
  const html = Profile.template(this)
  $("#profile-form").empty()
  $("div.profile").html(html)
}

Profile.failUpdate = function(xhr) {
  $.rails.enableFormElements(this)
  const errors = Profile.processError(xhr)
  $("#profile-update-error").text(errors)
}

Profile.submitFormAJAX = function($form, success, fail) {
  $.ajax({
    url: $form.attr("action"),
    type: ($form.find("input[name='_method']").val() || $form.attr("method")),
    data: new FormData($form[0]),//$form.serialize(),
    dataType: "json",
    contentType: false,
    processData: false
  })
  .done(success)
  .fail(fail)
}

Profile.processError = function(xhr) {
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

//----------------------------------------------------
// Document Ready.

$(document).ready(function() {
  if($("#profile-form-template").length <= 0) return;

  let source = $("#profile-form-template").html()
  Profile.formTemplate = Handlebars.compile(source)

  source = $("#profile-template").html()
  Profile.template = Handlebars.compile(source)

  $("#modal-form").hide()

  $('#modal-form').on('hidden.bs.modal', function (e) {
    $("#profile-form, #profile-load-error").empty()
  })
})

//-----------------------------------------------------------
// Shared Methods

Handlebars.registerHelper('humanize', humanize);

function humanize(str) {
  return str
    .replace(/^[\s_]+|[\s_]+$/g, '')
    .replace(/[_\s]+/g, ' ')
    .replace(/^[a-z]/, function(m) { return m.toUpperCase(); });
}
