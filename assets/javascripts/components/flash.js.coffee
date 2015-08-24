$(document).on 'ready page:load', ->
  goodbye = ->
    unless $(this).hasClass('fading')
      $(this).addClass('fading').fadeOut 'slow', =>
        $(this).remove()
  $(".flash-container").each ->
    $(this).on 'click', goodbye
  setTimeout ->
    $(".flash-container.go").each goodbye
  , 3000
