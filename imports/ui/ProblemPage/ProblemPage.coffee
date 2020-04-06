import React, {useState, useEffect} from 'react'
import {BackButton, Button, Page, Toolbar} from 'react-onsenui'
import {Problem} from "/imports/mathProblems/mathProblems"
import {teXifyAM} from "/imports/mathProblems/renderAM"
import DisplayProblem from "./DisplayProblem"
import MobileInput from "./MobileInput"
# import { insertSubmission } from "/imports/api/submissions.coffee"
import _ from "lodash"

initialResult =
  pass : true
  passTextsRequired : []
  passTextsOptional : []
  failTextsRequired : []
  failTextsOptional : []


export default ProblemPage = ({moduleKey, onPop}) ->

  [problem, setProblem] = useState {}
  [level, setLevel] = useState 1
  [answer, setAnswer] = useState ""
  [answered, setAnswered] = useState false
  [result, setResult] = useState initialResult

  getNewProblem = ->
    # TODO implement unsolvedProblems storing and rettreival
    setProblem newProblem = new Problem moduleKey, level, "de"
    setLevel newProblem.level
    setAnswer ""

  useEffect getNewProblem, [level]
  
  submit = (answer) -> console.log "we should submit #{answer}"

  contentStyle =
    padding: "8px"

  renderToolbar= ->
    <Toolbar>
      <div className="left"><BackButton>Module</BackButton></div>
    </Toolbar>

  <Page
    contentStyle={contentStyle}
    renderToolbar={renderToolbar}
  >
    <div>
      <DisplayProblem problem={problem}/>
      <MobileInput
        solution={problem?.solution}
        level={problem?.level}
        onSubmit={submit}
        onIncLevel={-> setLevel level+1}
        onDecLevel={-> setLevel level-1}
      />
    </div>
  </Page>