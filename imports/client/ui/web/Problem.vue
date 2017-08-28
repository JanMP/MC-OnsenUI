<template lang="jade">
.text-container
  display-problem(v-bind:problem="problem")
  div(v-show="!answered")
    el-form(ref="elForm")
      el-form-item(label="Antwort")
        el-input(ref="answerInput" v-model="answer" autofocus=true)
      el-form-item
        el-button.right(type="success" @click="webSubmit") OK
        el-button.right(type="info" @click="help") ?
        el-button-group
          el-button(type="primary" @click="decLevel") -
          el-button.wide(type="primary") Level {{level}}
          el-button(type="primary" @click="incLevel") +

  div(v-show="answered")
    display-result(v-bind:data="resultDisplayData")
    el-button(ref="nextButton" type="primary" @click="webGetNewProblem") Neue Aufgabe
</template>

<script lang="coffee">
import DisplayProblem from "/imports/client/ui/common/DisplayProblem.vue"
import problemMixin from "/imports/client/ui/common/Problem.mixin.coffee"
import DisplayResult from "./DisplayResult.vue"
return
  mixins : [problemMixin]
  computed :
    moduleKey : -> @$route.params.moduleKey
  components : { DisplayProblem, DisplayResult }
  methods :
    webGetNewProblem : ->
      @getNewProblem()
      @$nextTick -> @$refs.answerInput.$el.children[0].focus()
    webSubmit : ->
      @submit()
      @$nextTick ->
        @$refs.nextButton.$el.focus()
  mounted : ->
    @$refs.elForm.$el.onsubmit = (event) =>
      event.preventDefault()
      @webSubmit()
</script>

<style scoped lang="sass">
.right
  margin-left : 10px
  float : right
.wide
  width : 100px
</style>
