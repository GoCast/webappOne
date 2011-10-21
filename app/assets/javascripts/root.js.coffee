window.digest = ""

$ ->

  window.UsersPanelView = Backbone.View.extend
    el: "#users",

    initialize: ->
      @collection.bind "change", @updatePanel, this

    updatePanel: ->
      @$(".list").empty()
      @collection.each (user) ->
        window.userView = new UserView(model: user)
        @$(".list").append userView.render().el

  window.userList = new UserList()
  updateStatus()
  window.usersPanel = new UsersPanelView(collection: userList)

  SessionManager.capture.startAndWaitForUrl (url) ->
    $.get("/users?url=#{url}")
    SessionManager.capture.stop()

