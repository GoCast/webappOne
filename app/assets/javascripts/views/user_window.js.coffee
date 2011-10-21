window.zindex = 100;
window.initialWindowIncrement = 0;

window.UserWindow = Backbone.View.extend
  initialize: ->
    @addBindings()
    @addTemplate()

  className: "window",

  events:
    "click h1 .close"   : "close"
    "click .stop"       : "stopCapture"
    "click .start"      : "startCapture"
    "click .mute"       : "toggleMute"
    "click .unmute"     : "toggleMute"
    "change .bitrate"   : "changeBitrate"
    "change .framerate" : "changeFramerate"

  close: ->
    $(@el).hide()

  changeBitrate: ->
    bitrate = @$(".bitrate").val()
    SessionManager.bitrate.set bitrate

  changeFramerate: ->
    framerate = @$(".framerate").val()
    SessionManager.framerate.set framerate

  toggleMute: ->
    SessionManager.mic.toggle =>
      @updateVolumeControls()

  stopCapture: ->
    SessionManager.capture.stop =>
      @updateCaptureButtons()

  startCapture: ->
    SessionManager.capture.startAndWaitForUrl (url) =>
      @model.setUrl url
      @updateCaptureButtons()
      @updateVideo()
      @updateControls()

  addBindings: ->
    @model.bind "change", @render, this

  addTemplate: ->
    @template = compileJsTemplate "user_window"

  setAsDraggable: ->
    $(@el).draggable
      handle: "h1",
      start: (event, ui) =>
        $(@el).css({"z-index": zindex+=1})

  setAsResizable: ->
    $(@el).resizable
      minWidth: 250,
      minHeight: 200,
      alsoResize: "##{@id} .body .video",

      stop: (event, ui) =>
        @$("embed").width @$(".video").width()
        @$("embed").height @$(".video").height()

  positionWindow: ->
    $(@el).css
      left: 10 + (initialWindowIncrement+= 10),
      top: 70 + initialWindowIncrement,
      position: "absolute"

  updateVolumeControls: ->
    SessionManager.mic.get (data) =>
      if data.muted
        @$(".mute").hide()
        @$(".unmute").show()
      else
        @$(".mute").show()
        @$(".unmute").hide()
      @$(".volume.slider").slider
        min: 0,
        max: 100,
        value: data.vol,
        change: (event, ui) ->
          volume = $(this).slider('values',0)
          SessionManager.mic.set volume

  updateCaptureButtons: ->
    SessionManager.capture.get (data) =>
      if data.state == "stopped"
        @$(".stop").hide()
        @$(".start").show()
      else
        @$(".start").hide()
        @$(".stop").show()

  updateInfo: ->
    SessionManager.resolution.get (data) =>
      @$(".resolution").html("#{data.width}x#{data.height}")
    SessionManager.capture.getUrl (data) =>
      @$(".stream-url").html(data.rtsp_url)

  updateBitrate: ->
    SessionManager.bitrate.get (data) =>
      @$(".bitrate option").removeAttr("selected")
      @$(".bitrate-#{data.bitrate}").attr("selected", "selected")

  updateFramerate: ->
    SessionManager.framerate.get (data) =>
      @$(".framerate option").removeAttr("selected")
      @$(".framerate-#{data.fps}").attr("selected", "selected")

  updateControls: ->
    @setAsResizable()
    @updateVolumeControls()
    @updateCaptureButtons()
    @updateInfo()
    @updateBitrate()
    @updateFramerate()

  render: ->
    $(@el).html @template(@model.toJSON())
    @setAsDraggable()
    @positionWindow()
    @updateControls()
    this

  updateVideo: ->
    @$(".embed").attr("target", @model.get("url"))

  insert: ->
    if ($("##{@id}").length == 0)
      $("#body").append @render().el
    else
      $("##{@id}").show()