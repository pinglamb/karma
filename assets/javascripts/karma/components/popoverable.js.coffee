$(document).on 'ready page:load', ->
  $("[data-toggle=popover]").each ->
    $(this).popover
      html: true
      content: ->
        dom = $($(this).data('dom')).clone()
        # FIXME Don't know where to bind this kind of interactions is the best
        dom.find('.daterange').each ->
          new RangePicker(this)
        dom.find("[data-dismiss=popover]").click (e) =>
          e.preventDefault()
          $(this).popover('hide')
        dom
