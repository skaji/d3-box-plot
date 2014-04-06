'use strict'

this.boxPlot = (svg, data, option = {}) ->
  svg.attr('width', 500)  unless svg.attr('width')
  svg.attr('height', 300) unless svg.attr('height')

  option.yTickFormat ||= (y) -> y
  option.xTickFormat ||= (x) -> x
  option.plotKey ||=
      min: 'min', q1: 'q1', med: 'med', q3: 'q3', max: 'max', mean: 'mean'

  margin = top: 20, left: 50, bottom: 40, right: 20

  main = svg.append('g').attr
    width:  svg.attr('width')  - margin.left - margin.right
    height: svg.attr('height') - margin.top  - margin.bottom
    transform: "translate(#{margin.left},#{margin.top})"

  w = main.attr 'width'
  h = main.attr 'height'

  labels = data[0].values.map (v) -> v.key

  boxWidth  = w / labels.length
  boxMargin = 0
  if boxWidth > 30
    boxMargin = boxWidth - 25
    boxWidth  = 25
  else if 30 >= boxWidth > 20
    boxMargin = boxWidth - 20
    boxWidth  = 20
  else if 20 >= boxWidth > 10
    boxMargin = boxWidth - 10
    boxWidth  = 10

  yDomain = do (data) ->
    max = 0
    data.forEach (d) ->
      d.values.forEach (v) ->
        _max = v.values[0][option.plotKey.max]
        max = _max if max < _max
    max

  xScale = d3.scale.ordinal().domain(labels).rangePoints([0, w], 1)
  yScale = d3.scale.linear().domain([0, yDomain]).range([h, 0])
  xAxis  = d3.svg.axis().scale(xScale).tickFormat(option.xTickFromat)
  yAxis  = d3.svg.axis().scale(yScale).orient('left')
    .tickSize(-w).ticks(if h > 300 then 10 else 5).tickFormat(option.yTickFormat)

  main.append('g').classed('x axis', true).call(xAxis)
    .attr(transform: "translate(0,#{h})")
  main.append('g').classed('y axis', true).call(yAxis)

  box = d3.svg.box().scale(yScale).width(boxWidth).plotKey(option.plotKey)

  data.map (d, i) ->
    kind = d.key
    data = d.values.map (v) -> v.values[0]
    main.selectAll("g.#{kind}").data(data).enter()
      .append('g')
      .classed("box-#{kind}", true)
      .attr
        transform: (_d, _i) ->
          "translate(#{_i * (box.width() + boxMargin) + boxMargin/2},0)"
      .call(box)
