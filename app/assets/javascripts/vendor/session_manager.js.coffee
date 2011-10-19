SessionManager =

  capture:

    get: (callback) ->
      $.getJSON("/api/capture", callback)

    start: (callback) ->
      $.getJSON("/api/capture/start", callback)

    stop: (callback) ->
      $.getJSON("/api/capture/stop", callback)

    getUrl: (callback) ->
      $.getJSON("/api/capture/url", callback)


    startAndWaitForUrl: (callback) ->
      @start =>
        @get (data) =>
          @getUrl (data) ->
            callback(data.rtsp_url)

  volume:

    get: (callback) ->
      $.getJSON("/api/volume", callback)

    set: (volume, callback) ->
      $.getJSON("/api/volume/set?vol=#{volume}", callback)

    toggleMute: (callback) ->
      $.getJSON("/api/volume/toggle", callback)


  bitrate:

    get: (callback) ->
      $.getJSON("/api/bitrate", callback)

    set: (bitrate, callback) ->
      $.getJSON("/api/bitrate/set?bitrate=#{bitrate}", callback)

  framerate:

    get: (callback) ->
      $.getJSON("/api/framerate", callback)

    set: (framerate, callback) ->
      $.getJSON("/api/framerate/set?fps=#{framerate}", callback)

  resolution:

    get: (callback) ->
      $.getJSON("/api/resolution", callback)


window.SessionManager = SessionManager
