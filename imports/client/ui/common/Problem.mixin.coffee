import { Problem } from "/imports/client/mathproblems/mathproblems.coffee"
import { insertSubmission } from "/imports/api/submissions.coffee"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
import _ from "lodash"

export default mixin =
  data : ->
    problem : {}
    level : 1
    answer : ""
    answered : false
    result :
      pass : true
      passTextsRequired : []
      passTextsOptional : []
      failTextsRequired : []
      failTextsOptional : []
    inputHeight : "370px"
  created : -> @getNewProblem()
  computed :
    moduleKey : -> @$store.state.navigator.moduleKey
    resultDisplayData : ->
      result : @result
      answer : @answer
      answerTeX : teXifyAM @answer
      solutionTeX : @problem.solutionTeX
  methods :
    getNewProblem : ->
      @answered = false
      @problem = new Problem @moduleKey, @level
      @level = @problem.level
      @answer = ""
    submit : (answer) ->
      @answer = answer
      @inputHeight = "44px"
      @checkAnswer()
      if Meteor.userId()
        obj = _.pick @problem, [
          "moduleKey", "level", "score", "description", "skipExpression",
          "SVGData", "functionData"
        ]
        submissionData = Object.assign obj,
          answerCorrect : @result.pass
          date : new Date()
          problemTeX : @problem.problemTeX
          answer : @answer
        insertSubmission.call submissionData
    setInputHeight : (height) -> @inputHeight = height
    incLevel : ->
      @level +=1
      @getNewProblem()
    decLevel : ->
      @level -= 1
      @getNewProblem()
    checkAnswer : ->
      @result = @problem.checkAnswer @answer
      @answered = true
