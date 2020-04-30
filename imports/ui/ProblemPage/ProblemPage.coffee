import React, {useState, useEffect} from 'react'
import {BackButton, BottomToolbar, Button, Page, Toolbar} from 'react-onsenui'
import {Problem} from "/imports/mathProblems/mathProblems"
import {teXifyAM} from "/imports/mathProblems/renderAM"
import DisplayProblem from "./DisplayProblem"
import DisplayResult from "./DisplayResult"
import MobileInput from "./MobileInput"
# import { insertSubmission } from "/imports/api/submissions.coffee"
import ErrorBoundary from '/imports/ui/ErrorBoundary'
import _ from "lodash"


#TODO adjust this for different phone models
bottomOffset = 30

export default ProblemPage = ({moduleKey, onPop}) ->

  [problem, setProblem] = useState {}
  [level, setLevel] = useState 1
  [answered, setAnswered] = useState false
  [resultDisplayProps, setResultDisplayProps] = useState {}
  [toolbarHeight, setToolbarHeight] = useState 0
  [errorBoundaryKey, setErrorBoundaryKey] = useState 0

  getNewProblem = ->
    # TODO implement unsolvedProblems storing and rettreival
    setProblem newProblem = new Problem moduleKey, level, "de"
    setLevel newProblem.level
    setAnswered false

  onError = ->
    console.log "ErrorBoundary Caught an Error!"
    setErrorBoundaryKey errorBoundaryKey + 1
    getNewProblem()

  useEffect getNewProblem, [level]

  useEffect ->
    elementHeight = document.getElementById("theInput")?.clientHeight ? 0
    setToolbarHeight elementHeight + bottomOffset
  , [problem, answered]
  
  submit = (answer) ->
    setAnswered true
    result = problem.checkAnswer answer
    setResultDisplayProps
      result: result
      answer: answer
      solutionTeX: problem.solutionTeX
  
  contentStyle =
    padding: "8px"
    bottom: toolbarHeight

  renderToolbar= ->
    <Toolbar>
      <div className="left"><BackButton>Module</BackButton></div>
    </Toolbar>

  renderBottomToolbar = ->
    if answered
      <BottomToolbar style={padding: "4px", height: toolbarHeight}>
        <Button
          id="theInput"
          modifier="large"
          onClick={getNewProblem}
        >Neue Aufgabe</Button>
      </BottomToolbar>
    else
      <BottomToolbar style={height: toolbarHeight}>
        <MobileInput
          solution={problem?.solution}
          level={problem?.level}
          onSubmit={submit}
          onIncLevel={-> setLevel level+1}
          onDecLevel={-> setLevel level-1}
        />
      </BottomToolbar>

  <Page
    contentStyle={contentStyle}
    renderToolbar={renderToolbar}
    renderBottomToolbar={renderBottomToolbar}
  >
    <div>
      <ErrorBoundary key={errorBoundaryKey} onError={onError}>
        {
          if answered
            <DisplayResult {resultDisplayProps...}/>
          else
              <DisplayProblem problem={problem}/>
        }
      </ErrorBoundary>
    </div>
  </Page>