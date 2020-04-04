import React, {useState, useEffect, useRef} from 'react'
import {GeometryDraw} from "/imports/mathProblems/geometryDraw"

export default GeometryDrawDisplay = ({data}) ->

  [drawing, setDrawing] = useState {}
  svg = useRef null

  useEffect ->
    drawing.paper?.clear()
    setDrawing newDrawing = new GeometryDraw svg.current
    newDrawing.draw?(data)
    console.log drawing
    return
  , [data]

  <svg ref={svg} style={backgroundColor: "white", padding:"10px"} width="90%" preserveAspectRatio="xMidYMid meet"/>
