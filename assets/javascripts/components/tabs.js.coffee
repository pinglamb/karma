$(document).on 'ready page:load', ->
  $(".nav-tabs").each ->
    unless $(this).hasClass("nav-tabs-raw")
      $(this).find("a").click (e) ->
        e.preventDefault()
        $(this).tab('show')
      if $(this).data("default")? && (tab = $(this).data("default")).length > 0
        $(this).find("a[href=##{tab}]").tab('show')
      else if (tab = Params.get("tab")).length > 0
        $(this).find("a[href=##{tab}]").tab('show')
      else
        $(this).find("a:first").tab('show')
