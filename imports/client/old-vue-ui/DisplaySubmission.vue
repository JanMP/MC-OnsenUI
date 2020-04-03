<template lang="jade">
.text-container
  h4 {{$t('aufgabe')}}:
  display-problem(v-bind:problem="submission")
  h4 {{$t('antwort')}}:
  p.centered {{submission.answer}}
    span.icon-span(v-if="submission.answerCorrect")
      icon.icon.pass(name="check")
    span.icon-span(v-else)
      icon.icon.fail(name="times")

</template>

<script lang="coffee">
import DisplayProblem from "./DisplayProblem.vue"
return
  computed :
    result : ->
      if @submission.answerCorrect
        @$t 'korrekt'
      else
        @$t 'nichtKorrekt'
  props : ["submission"]
  components : { DisplayProblem }
</script>

<style scoped lang="sass">
.centered
  text-align : center
  font-size : 1.2em
h4
  margin-top : 10px
.icon-span
  margin-left : 10px
.icon
  width : 1em
  height : 1em
  &.fail
    color : #FF4949
  &.pass
    color : #13CE66
  &.warn
    color : #F7BA2A
</style>
