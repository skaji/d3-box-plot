'use strict'

d3.svg.box = () ->
  plotKey =
    min: 'min', q1: 'q1', med: 'med', q3: 'q3', max: 'max', mean: 'mean'
  scale = (d) -> d
  width = 30

  whisker = (source, target) ->
    () ->
      s = this.append('g').classed('whisker', true)
      s.append('path').attr
        d: "M#{source[0]},#{source[1]}L#{target[0]},#{target[1]}"
      s.append('path').attr
        d: "M0,#{target[1]}L#{target[0] * 2},#{target[1]}"

  box = (g) ->
    g.each () ->
      g = d3.select(this)

      six = this.__data__
      scaled = {}
      d3.keys(six).forEach (k) -> scaled[k] = scale(six[k])

      g.append('rect').attr
        width: width, height: Math.abs(scaled[plotKey.q3] - scaled[plotKey.q1]),
        x: 0, y: scaled[plotKey.q3]

      g.append('line').attr
        x1: 0, x2: width, y1: scaled[plotKey.med], y2: scaled[plotKey.med]

      if scaled[plotKey.mean]
        g.append('line').attr
          x1: 0, x2: width, y1: scaled[plotKey.mean], y2: scaled[plotKey.mean],
          'stroke-dasharray': '2 1'

      g.call whisker([width/2, scaled[plotKey.q1]], [width/2, scaled[plotKey.min]])
      g.call whisker([width/2, scaled[plotKey.q3]], [width/2, scaled[plotKey.max]])

  box.scale = (_s) ->
    return scale unless _s
    scale = _s
    box
  box.width = (_w) ->
    return width unless _w
    width = _w
    box
  box.plotKey = (_k) ->
    return key unless _k
    plotKey = _k
    box

  box
