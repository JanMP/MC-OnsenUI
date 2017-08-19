<template lang="jade">
v-ons-page
  custom-toolbar(title="Aufgabe")
  .content(v-bind:style="contentBottomStyle")
    display-problem(v-bind:problem="problem")
    template(v-if="answered")
      display-result(v-bind:data="resultDisplayData")
  v-ons-bottom-toolbar(v-if="answered")
    v-ons-button(modifier="large quiet" @click="getNewProblem") Neue Aufgabe
  v-ons-bottom-toolbar(v-else style="height : 305px")
    math-mobile-input(v-bind:math="answer" @submit="answer => submit(answer)")

</template>

<script lang="coffee">
import { Problem } from "/imports/client/mathproblems/mathproblems.coffee"
import MathDisplay from "./MathDisplay.vue"
import DisplayProblem from "./DisplayProblem.vue"
import DisplayResult from "./DisplayResult.vue"
import MathMobileInput from "./MathMobileInput.vue"
import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
return
  data : ->
    problem : {}
    level : 1
    answer : ""
    answered : false
    result :
      answerCorrect : true
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
    contentBottomStyle : ->
      if @answered then "bottom : 44px" else "bottom : 305px"
  methods :
    getNewProblem : ->
      @answered = false
      @problem = new Problem @moduleKey, @level
      @answer = ""
    submit : (answer) ->
      @answer = answer
      @checkAnswer()
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
