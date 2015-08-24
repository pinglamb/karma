class @RangePicker
  constructor: (dom) ->
    @dom = $(dom)

    empty = @dom.val().length == 0
    @dom.daterangepicker
      locale:
        cancelLabel: 'Clear'
      opens: 'left'
      ranges:
        'This Week':  [moment().startOf('week'), moment().endOf('week')]
        'Last Week':  [moment().subtract(1, 'week').startOf('week'), moment().subtract(1, 'week').endOf('week')]
        'Next Week':  [moment().add(1, 'week').startOf('week'), moment().add(1, 'week').endOf('week')]
        'This Month': [moment().startOf('month'), moment().endOf('month')]
        'Last 30 Days': [moment().subtract(30, 'day'), moment()]
        'Next 30 Days': [moment(), moment().add(30, 'day')]
    @dom.on 'cancel.daterangepicker', =>
      @dom.val('')
    @dom.val('') if empty

$(document).on 'ready page:load', ->
  $(".daterange").each ->
    new RangePicker(this)
