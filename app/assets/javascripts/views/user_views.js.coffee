window.UserView = Backbone.View.extend
  initialize: ->
    @addBindings()
    @addTemplate()

  events:
    "click": "initiateConversation"

  addBindings: ->
    @model.bind "change", @render, this

  addTemplate: ->
    @template = compileJsTemplate "user"

  render: ->
    $(@el).html @template(@model.toJSON())
    this

  initiateConversation: ->
    @openCurrentUserWindow()
    @openUserWindow()

  openCurrentUserWindow: ->
    window.currentUserWindow = new UserWindow(model: window.currentUser, id: "current-user-window")
    currentUserWindow.insert()

  openUserWindow: ->
    # SessionManager.capture.startAndWaitForUrl (url) ->
    #   @model.url = url
    #   @window = new UserWindow(model: @model, id: "user-window-#{@model.id}")
    #   @window.insert()