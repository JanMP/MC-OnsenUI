<template lang="jade">
v-ons-page
  custom-toolbar(title="Aufgabe")
  .content(v-bind:style="'bottom : '+inputHeight")
    .text-container
      display-problem(v-bind:problem="problem")
      template(v-if="answered")
        display-result(v-bind:data="resultDisplayData")
  v-ons-bottom-toolbar(v-if="answered" style="height : 44px")
    v-ons-button(modifier="large quiet" @click="getNewProblem") Neue Aufgabe
  v-ons-bottom-toolbar(v-else v-bind:style="'height : '+inputHeight")
    math-mobile-input(v-bind:math="answer" v-bind:level="problem.level" v-bind:solution="problem.solution" @submit="answer => submitMobile(answer)" @incLevel="incLevel" @decLevel="decLevel" @setHeight="height => setInputHeight(height)")
</template>

<script lang="coffee">
import DisplayProblem from "/imports/client/ui/DisplayProblem.vue"
import DisplayResult from "./DisplayResult.vue"
import problemMixin from "/imports/client/ui/Problem.mixin.coffee"
import MathMobileInput from "./MathMobileInput.vue"
return
  data : ->
    inputHeight : "370px"
  mixins : [problemMixin]
  computed :
    moduleKey : -> @$store.state.navigator.moduleKey
  methods :
    submitMobile : (answer) ->
      @answer = answer
      @inputHeight = "44px"
      @submit()
    setInputHeight : (height) -> @inputHeight = height

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
