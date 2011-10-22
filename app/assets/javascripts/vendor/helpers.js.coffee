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

      userList.each (user) ->
        if user.get("status") == "Online"
          if $("#common-window-#{user.id}").length > 0
            $("#common-window-#{user.id}").remove()
            commonWindow = new CommonUserWindow(model: user, id: "common-window-#{user.get('id')}")
            commonWindow.insert()

    setTimeout "updateStatus()", 1000