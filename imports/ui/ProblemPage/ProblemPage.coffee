import React, {useState, useEffect} from 'react'
import {Button, Page} from 'react-onsenui'
import {Problem} from "/imports/mathProblems/mathProblems"
import {teXifyAM} from "/imports/mathProblems/renderAM"
import DisplayProblem from "./DisplayProblem"
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
    setProblem newProblem = new Problem "strahlensatz", level, "de"
    setLevel newProblem.level
    setAnswer ""
  
  useEffect getNewProblem, []

  style =
    padding: "1rem"

  <Page
    contentStyle={padding: 8}
  >
    <div>
      <Button onClick={getNewProblem}>get new Problem</Button>
      <DisplayProblem problem={problem}/>
    </div>
  </Page>