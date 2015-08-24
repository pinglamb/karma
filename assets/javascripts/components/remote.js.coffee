class @RemoteContent
  constructor: (dom) ->
    @dom = $(dom)
    @url = $(dom).data("url")

    $
      .ajax
        url: @url
        type: 'GET'
        beforeSend: =>
          @dom.html('<div class="text-center loading"><i class="fa fa-spin fa-spinner" /></div>')
      .done (r) =>
        r = $(r)
        @dom.html(r)

        # FIXME Not sure when to bind the js functions back
        new Chart(r)
        r.find(".aspect-fill img").resizeToParent()

$(document).on 'ready page:load', ->
  $(".remote-content").each ->
    new RemoteContent(this)
