window.User = Backbone.Model.extend

  setUrl: (url) ->
    @set { url: url }
    url

window.UserList = Backbone.Collection.extend
  model: User