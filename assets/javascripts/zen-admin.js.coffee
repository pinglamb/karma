#= require bootstrap
#= require underscore/underscore
#= require holderjs/holder
#= require jquery.resizeimagetoparent
#= require jquery.hotkeys/jquery.hotkeys
#= require bootstrap-wysiwyg-steveathon/src/bootstrap-wysiwyg
#= require ./external/ace-wysiwyg
#= require moment/moment
#= require bootstrap-daterangepicker/daterangepicker
#= require bootstrap-switch/dist/js/bootstrap-switch
#= require bootstrap-file-input/bootstrap.file-input
#= require ./external/pickers
#= require_self
#= require_tree ./components

$(document).on 'ready page:load', ->
  $('[data-toggle="tooltip"]').tooltip()

  $("form .form-section").click ->
    $(this).closest("form").find(".form-section").removeClass("active")
    $(this).addClass("active")

  $(".btn-submit").on 'click', (e) ->
    e.preventDefault()
    $($(this).data('target')).submit()

  $(".aspect-fill img").resizeToParent()

  $("input.switch").bootstrapSwitch
    size: 'small'

  $(".bootstrap-file-input").bootstrapFileInput()
