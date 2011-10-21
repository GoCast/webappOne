$jsonp = (slug, options) ->
  defaultOptions =
    url: "http://localhost:8082#{slug}"
    callbackParameter: "callback"

  $.jsonp _.extend(defaultOptions, options)

SessionManager =

  capture:

    get: (callback) ->
      $jsonp "/GET_CAPTURE_STATE"
        success: callback

    start: (callback) ->
      $jsonp "/START_CAPTURE"
        success: callback

    stop: (callback) ->
      $jsonp "/STOP_CAPTURE"
        success: callback

    getUrl: (callback) ->
      $jsonp "/GET_RTSP_URL"
        success: callback

    startAndWaitForUrl: (callback) ->
      @start =>
        @get (data) =>
          @getUrl (data) ->
            callback(data.rtsp_url)

  mic:

    get: (callback) ->
      $jsonp "/GET_MIC_VOLUME"
        success: callback

    set: (volume, callback) ->
      $jsonp "/SET_MIC_VOLUME"
        success: callback
        data:
          vol: volume

    toggle: (callback) ->
      $jsonp "/SET_MIC_TOGGLE_MUTE"
        success: callback


  speaker:

    get: (callback) ->
      $jsonp "/GET_SPEAKER_VOLUME"
        success: callback

    set: (volume, callback) ->
      $jsonp "/SET_SPEAKER_VOLUME"
        success: callback
        data:
          vol: volume

    toggle: (callback) ->
      $jsonp "/SET_SPEAKER_TOGGLE_MUTE"
        success: callback

  bitrate:

    get: (callback) ->
      $jsonp "/GET_BITRATE"
        success: callback

    set: (bitrate, callback) ->
      $jsonp "/SET_BITRATE"
        success: callback
        data:
          bitrate: bitrate

  framerate:

    get: (callback) ->
      $jsonp "/GET_FRAMERATE"
        success: callback

    set: (fps, callback) ->
      $jsonp "/SET_FRAMERATE"
        success: callback
        data:
          fps: fps

  resolution:

    get: (callback) ->
      $jsonp "/GET_RESOLUTION"
        success: callback


window.SessionManager = SessionManager
