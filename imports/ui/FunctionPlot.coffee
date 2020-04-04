import React from 'react'
import math from "mathjs"

arrowLength = 1
scale = 100
margin = 30
fontSize = 40

style =
  grid:
    fill: "#aaa"
  axis:
    strokeWidth: 6
    stroke: "#333"
  axisLabel:
    fill: "#333"
    fontWeight: 100
    fontSize: 60
    fontFamily: "mono"
  tickLabel:
    fontWeight: 100
    fontSize: fontSize
    fontFamily: "mono"
  plot:
    strokeWidth: 7
    stroke: "#111"
    fill: "none"


range = (domain) -> math.floor(domain[1])-math.ceil(domain[0])

export default FunctionPlot = ({data}) ->

  return null unless data?

  # make sure the axis are in the displayed area
  xMin =
    if data.xAxis.domain[0] >= 0 and data.xAxis.domain[1] >= 0 then -1
    else math.floor data.xAxis.domain[0]
  xMax =
    if data.xAxis.domain[0] <= 0 and data.xAxis.domain[1] <= 0 then 1
    else math.ceil data.xAxis.domain[1]
  yMin =
    if data.yAxis.domain[0] >= 0 and data.yAxis.domain[1] >= 0 then -1
    else math.floor data.yAxis.domain[0]
  yMax =
    if data.yAxis.domain[0] <= 0 and data.yAxis.domain[1] <= 0 then 1
    else math.ceil data.yAxis.domain[1]

  ticksX = [xMin..xMax]
  ticksY = [yMin..yMax]
  
  origin =
    x : -xMin * scale
    y : (yMax + arrowLength) * scale

  width = scale * (xMax - xMin + arrowLength)
  height = scale * (yMax - yMin + arrowLength)

  viewBox = "#{-margin} #{-margin} #{width+2*margin} #{height+2*margin}"

  functionPathTransform = "translate(#{origin.x},#{origin.y})"
  arrowYTransform = "translate(#{origin.x} -5)"
  arrowXTransform = "translate(#{width+5} #{origin.y}) rotate(90)"

  math.config number: "number"
  
  fktStr = data.data?[0]?.fn
  functionPath = "M#{(xMin-1)*scale},#{-math.eval(fktStr, {x : (xMin-1)})*scale}"
  for x in [(xMin-1)..(xMax+1)] by .01
    functionPath += "L#{x*scale},#{-math.eval(fktStr, {x})*scale}"


  <div>
    <svg
      width="100%"
      height="100%"
      viewBox={viewBox}
      title={data}
    >
      { #point grid
        ticksX.map (tickX) ->
          <g key={tickX}>
          {
            ticksY.map (tickY) ->
              <circle
                key={tickY}
                style={style.grid}
                cx={tickX * scale + origin.x}
                cy={-tickY * scale + origin.y}
                r={4}
              />
          }
          </g>
      }
      {### y-axis ###}
      <line
        style={style.axis}
        x1={origin.x}
        y1={0}
        x2={origin.x}
        y2={height}
      />
      <path d="M 0,0 l 13, 20 l -26, 0" transform={arrowYTransform}/>
      <text
        style={style.axisLabel}
        x={origin.x}
        y={0}
        dx={30}
        dy={30}
      >{data.yAxis.label}</text>
      {# y-axis ticks and their labels
        ticksY.map (tick) ->
          <g key={tick}>
            <circle
              cx={origin.x}
              cy={- tick * scale + origin.y}
              r={7}
            />
            <text
              style={style.tickLabel}
              y={- tick * scale + origin.y}
              x={origin.x}
              textAnchor={if tick < 0 then 'start' else 'end'}
              dx={if tick < 0 then 20 else -20}
              dy={11}
            >{if tick is 0 then '' else tick}</text>
          </g>
      }
      {### x-axis ###}
      <line
        style={style.axis}
        x1={0}
        y1={origin.y}
        x2={width}
        y2={origin.y}
      />
      <path d="M 0,0 l 13, 20 l -26, 0" transform={arrowXTransform}/>
      <text
        style={style.axisLabel}
        x={width}
        y={origin.y}
        dx={0}
        dy={50}
        textAnchor="end"
      >{data.xAxis.label}</text>
      {# x-axis ticks and thier labels
        ticksX.map (tick) ->
          <g key={tick}>
            <circle
              cx={tick * scale + origin.x}
              cy={origin.y}
              r={7}
            />
            <text
              style={style.tickLabel}
              x={tick * scale + origin.x}
              y={origin.y}
              textAnchor="middle"
              dy={if tick > 0 then -20 else 60}
            >{if tick is 0 then '' else tick}</text>
          </g>
      }
      <path
        style={style.plot}
        d={functionPath}
        transform={functionPathTransform}
      />
    </svg>
  </div>