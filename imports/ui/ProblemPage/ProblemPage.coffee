import React, {useState, useEffect} from 'react'
import {Button, Page} from 'react-onsenui'
import {Problem} from "/imports/mathProblems/mathProblems"
import {teXifyAM} from "/imports/mathProblems/renderAM"
# import { insertSubmission } from "/imports/api/submissions.coffee"
import _ from "lodash"

initialResult =
  pass : true
  passTextsRequired : []
  passTextsOptional : []
  failTextsRequired : []
  failTextsOptional : []


export default ProblemPage = ->

  [problem, setProblem] = useState {}
  [level, setLevel] = useState 1
  [answer, setAnswer] = useState ""
  [answered, setAnswered] = useState false
  [result, setResult] = useState initialResult


  getNewProblem = ->
    # TODO implement unsolvedProblems storing and rettreival
    setProblem newProblem = new Problem "quadraticFunctions", level, "de"
    setLevel newProblem.level
    setAnswer ""
  
  useEffect getNewProblem, []

  style =
    padding: "1rem"

  <Page style={style}>
    <Button onClick={getNewProblem}>get new Problem</Button>
    <pre>{JSON.stringify problem, null, 2}</pre>
  </Page>