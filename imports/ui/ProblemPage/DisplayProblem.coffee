import React, {useState, useEffect} from 'react'
import {Button, Page} from 'react-onsenui'
import Katex from '/imports/ui/Katex'
import FunctionPlot from '/imports/ui/FunctionPlot'
import GeometryDrawDisplay from '/imports/ui/GeometryDrawDisplay'

export default DisplayProblem = ({problem}) ->

  <>
    <h3>{problem?.title}</h3>
    <p>{problem?.description}</p>
    {<Katex tex={problem?.problemTeX}/> unless problem.skipExpression}
    <FunctionPlot data={problem?.functionPlotData}/>
    {<GeometryDrawDisplay data={problem?.geometryDrawData}/> if problem?.geometryDrawData?}
    {<pre>{JSON.stringify problem, null, 2}</pre> if false}
  </>
