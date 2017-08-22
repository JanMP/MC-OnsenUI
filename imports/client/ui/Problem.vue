<template lang="jade">
v-ons-page
  custom-toolbar(title="Aufgabe")
  .content(v-bind:style="'bottom : '+inputHeight")
    display-problem(v-bind:problem="problem")
    template(v-if="answered")
      display-result(v-bind:data="resultDisplayData")
  v-ons-bottom-toolbar(v-if="answered" style="height : 44px")
    v-ons-button(modifier="large quiet" @click="getNewProblem") Neue Aufgabe
  v-ons-bottom-toolbar(v-else v-bind:style="'height : '+inputHeight")
    math-mobile-input(v-bind:math="answer" v-bind:level="problem.level" v-bind:solution="problem.solution" @submit="answer => submit(answer)" @incLevel="incLevel" @decLevel="decLevel" @setHeight="height => setInputHeight(height)")

</template>

<script lang="coffee">
import { Problem } from "/imports/client/mathproblems/mathproblems.coffee"
import { insertSubmission } from "/imports/api/submissions.coffee"
import MathDisplay from "./MathDisplay.vue"
import DisplayProblem from "./DisplayProblem.vue"
import DisplayResult from "./DisplayResult.vue"
import MathMobileInput from "./MathMobileInput.vue"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
import _ from "lodash"
return
  data : ->
    problem : {}
    level : 1
    answer : ""
    answered : false
    inputHeight : "44px"
    result :
      pass : true
      passTextsRequired : []
      passTextsOptional : []
      failTextsRequired : []
      failTextsOptional : []
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
          problem : @problem.problemTeX
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
  components : { DisplayProblem, DisplayResult, MathDisplay, MathMobileInput }

</script>

<style scoped lang="sass">
.problem-container
  margin : 0 auto 0 auto
.relative
  position : static
.bottom
  position : fixed
  bottom : 0
  width : 100%
</style>
