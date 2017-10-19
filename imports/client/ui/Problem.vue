<template lang="jade">
v-ons-page
  custom-toolbar(title="Aufgabe" v-bind:showBackButton="true")
  .content(v-bind:style="'bottom : '+inputHeight")
    .text-container
      display-problem(v-bind:problem="problem")
      template(v-if="answered")
        display-result(v-bind:data="resultDisplayData")
  v-ons-bottom-toolbar(v-if="answered" style="height : 44px")
    v-ons-button(modifier="large quiet" @click="getNewProblem") {{$t('neueAufgabe')}}
  v-ons-bottom-toolbar(v-else v-bind:style="'height : '+inputHeight")
    math-mobile-input(v-bind:math="answer" v-bind:level="problem.level" v-bind:solution="problem.solution" @submit="answer => submit(answer)" @incLevel="incLevel" @decLevel="decLevel" @setHeight="height => setInputHeight(height)")
</template>

<script lang="coffee">
import { Problem } from "/imports/client/mathproblems/mathproblems.coffee"
import { insertSubmission } from "/imports/api/submissions.coffee"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
import _ from "lodash"
import DisplayProblem from "/imports/client/ui/DisplayProblem.vue"
import DisplayResult from "./DisplayResult.vue"
import MathMobileInput from "./MathMobileInput.vue"
return
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
      #get a new Problem to make sure level is valid
      language = @$store.state.locale.language
      newProblem = new Problem @moduleKey, @level, language
      @level = newProblem.level
      storedProblem = @$store.state.unsolvedProblems?.problem?[@moduleKey]?[@level]
      if storedProblem?
        @problem = @$store.state.unsolvedProblems?.problem?[@moduleKey]?[@level]
      else
        @problem = newProblem
        problemToStore = Object.assign @problem,
          moduleKey : @moduleKey
          level : @level
        @$store.commit "unsolvedProblems/add", problemToStore
      @answer = ""
    submit : (answer) ->
      @answer = answer
      @$store.commit "unsolvedProblems/remove",
        moduleKey : @moduleKey
        level : @level
      @inputHeight = "44px"
      @checkAnswer()
      if Meteor.userId()
        obj = _.pick @problem, [
          "moduleKey", "level", "score", "description", "skipExpression", "geometryDrawData", "functionPlotData", "problemTeX"
        ]
        submissionData = Object.assign obj,
          answerCorrect : @result.pass
          date : new Date()
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
  components : { DisplayProblem, DisplayResult, MathMobileInput }
</script>

<style scoped lang="sass">
.container
  padding : 10px
.relative
  position : static
.bottom
  position : fixed
  bottom : 0
  width : 100%
</style>
