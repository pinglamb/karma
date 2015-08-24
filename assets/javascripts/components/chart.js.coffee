class @Chart
  constructor: (dom) ->
    @dom = $(dom)
    c3.generate
      data:
        x: 'x'
        columns: [
          @dom.data("x")
          _.map(@dom.data("y"), (n) -> if isNaN(n) then n else Math.round(n))
        ]
      axis:
        x:
          type: 'timeseries'
          tick:
            format: '%b-%d'


$(document).on 'ready page:load', ->
  $("#chart").each ->
    new Chart(this)
