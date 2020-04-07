import React, {useState} from 'react'
import {BackButton, Button, Col, Page, Row, Toolbar} from 'react-onsenui'
import style from './MobileInputStyle'
import _ from 'lodash'

keys = [
  {symbol: "←", className: "control"}, {symbol: "del", className: "control"}, {symbol: "→", className: "control"},
  {symbol: "(", className: "operator"}, {symbol: ")", className: "operator"},
  {symbol: "7", className: "number"}, {symbol: "8", className: "number"}, {symbol: "9", className: "number"},
  {symbol: "/", className: "operator"}, {symbol: "√", className: "operator"},
  {symbol: "4", className: "number"}, {symbol: "5", className: "number"}, {symbol: "6", className: "number"},
  {symbol: "*", className: "operator"}, {symbol: "^", className: "operator"},
  {symbol: "1", className: "number"}, {symbol: "2", className: "number"}, {symbol: "3", className: "number"},
  {symbol: "-", className: "operator"}, {symbol: ",", className: "control"},
  {symbol: "0", className: "number"}, {symbol: ".", className: "operator"}, {symbol: "=", className: "operator"},
  {symbol: "+", className: "operator"}, {symbol: "?", className: "control"}
]

letterKeysForSolution = (solution) ->
  solutionStr = solution ? ""
  arr = []
  ["sin", "cos", "tan", "cot"].forEach (str) ->
    newSolutionStr = solutionStr.replace str, ""
    if newSolutionStr isnt solutionStr
      arr.push str
      solutionStr = newSolutionStr
  symbols = arr.concat _.sortBy _.uniq /([a-z])/ig[Symbol.match] solutionStr
  #return
  symbols.map (symbol) ->
    symbol : symbol
    width : "#{100/symbols.length}%"


export default MobileInput = ({solution, level, onSubmit, onIncLevel, onDecLevel})->


  [cursorPosition, setCursorPosition] = useState 0
  [answerString, setAnswerString] = useState ""

  letterKeys = letterKeysForSolution solution

  insert = (symbol) ->
    beforeCursor = answerString.slice 0, cursorPosition
    afterCursor = answerString.slice cursorPosition
    setAnswerString beforeCursor.concat symbol, afterCursor
    setCursorPosition cursorPosition+symbol.length
  cursorLeft = ->
    if cursorPosition > 0 then setCursorPosition cursorPosition-1
  cursorRight = ->
    if cursorPosition < answerString.length then setCursorPosition cursorPosition+1
  del = ->
    if cursorPosition > 0
      before = answerString.slice 0, cursorPosition-1
      after = answerString.slice cursorPosition
      setAnswerString before.concat after
      setCursorPosition cursorPosition-1

  processKey = (symbol) ->
    switch symbol
      when "del" then del()
      when "←" then cursorLeft()
      when "→" then cursorRight()
      when "√" then insert "sqrt("
      else insert symbol

  <div className="mobile-input" id="theInput">
    <div className="display">
      <span>{answerString.slice 0, cursorPosition}</span>
      <span className="cursor">│</span>
      <span>{answerString.slice cursorPosition}</span>
    </div>
    {
      if letterKeys
        <Row>
          {
            letterKeys.map (key) ->
              <Col width={key.width} key={key.symbol}>
                <div className="button-container">
                  <div
                    className="math-button special"
                    onClick={-> processKey key.symbol}
                  >{key.symbol}</div>
                </div>
              </Col>

          }
        </Row>
    }
    <Row>
      {
        keys.map (key) ->
          <Col width="20%" key={key.symbol}>
            <div className="button-container">
              <div
                className="math-button #{key.className}"
                onClick={-> processKey key.symbol}
              >{key.symbol}</div>
            </div>
          </Col>
      }
    </Row>
    <Row>
      <Col width="60%">
        <Row>
          <Col width="33%"><div className="master-button" onClick={onDecLevel}>-</div></Col>
          <Col width="33%"><div className="master-button">Level {level}</div></Col>
          <Col width="33%"><div className="master-button" onClick={onIncLevel}>+</div></Col>
        </Row>
      </Col>
      <Col width="40%">
        <div className="master-button" onClick={-> onSubmit answerString}>Abgeben</div>
      </Col>
    </Row>
  </div>