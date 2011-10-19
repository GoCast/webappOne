window.compileJsTemplate = (name) ->
  Handlebars.compile $("#js_template_#{ name }").html()

window.updateStatus = ->
  $.getJSON "/status.json", {digest: digest}, (data) ->
    if (data.changed)
      userList.reset data.users
      window.digest = data.digest
      window.currentUser = new User(data.current_user)
      window.currentUser.isCurrentUser = true
      userList.trigger("change")
    setTimeout "updateStatus()", 1000