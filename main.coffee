w = 500
h = 300
d3.csv './data.csv', (data) ->
  nest = d3.nest()
    .key (d) -> d.kind
    .key (d) -> d.label
    .entries data

  boxPlot(
    d3.select('body').append('svg').attr(width: w, height: h),
    nest
  )
