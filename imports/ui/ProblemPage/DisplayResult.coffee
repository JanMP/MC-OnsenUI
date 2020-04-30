import React, {useState, useEffect} from 'react'
import {Col, Row} from 'react-onsenui'
import Katex from '/imports/ui/Katex'
import { teXifyAM } from "/imports/mathProblems/renderAM.coffee"
import "./DisplayResultStyle"
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faCheck, faTimes } from '@fortawesome/free-solid-svg-icons'

lists = []
[true, false].forEach (pass) ->
  [true,false].forEach (required) ->
    passString = if pass then 'pass' else 'fail'
    requiredString = if required then 'Required' else 'Optional'
    lists.push {
      pass, required, passString, requiredString
      key: "#{passString}Texts#{requiredString}"
    }

Details = ({result}) ->
  lists.map (list, index) ->
    return null unless result[list.key].length
    result[list.key].map (rowText, index2) ->
      <Row className="detail-row" key={"#{index}-#{index2}"}>
        <Col width={64} className="icon-column">
          <FontAwesomeIcon
            className={"#{list.passString} text icon"}
            icon={if list.pass then faCheck else faTimes}
          />
        </Col>
        <Col className="text-column">{rowText}</Col>
      </Row>
    

export default DisplayResult = ({result, answer, solutionTeX}) ->

  <div className="display-result">
    <h4>Deine Antwort:</h4>
    <Katex tex={teXifyAM answer}/>
    <h4>Die Musterlösung:</h4>
    <Katex tex={solutionTeX}/>
    {if result.pass
      <div className="result-header pass back">Das Ergebnis ist korrekt.</div>
    else
      <div className="result-header fail back">Das Ergebnis ist NICHT korrekt.</div>}
    <Details result={result}/>
  </div>