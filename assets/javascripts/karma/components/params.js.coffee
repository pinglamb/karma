class @Params
  constructor: -> #
  @get: (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
    results = regex.exec(location.search)
    if results? then decodeURIComponent(results[1].replace(/\+/g, " ")) else ""
