<template lang="jade">
v-ons-list-item
  .center
    .container
      p.date {{timeAgo}}:
      display-problem.problem(v-bind:problem="problem")
      .flex
        .result {{submission.answer}}
        .pass.text.icon(v-if="submission.answerCorrect")
          v-ons-icon(icon="fa-check")
        .fail.text.icon(v-else)
          v-ons-icon(icon="fa-times")




</template>

<script lang="coffee">
import { getModuleTitle } from "/imports/mathProblems/getModulesList.coffee"
import DisplayProblem from "./DisplayProblem.vue"
return
  props :
    submission :
      type : Object
      required : true
  computed :
    timeAgo : -> moment(@submission.date).fromNow()
    problem : ->
      Object.assign {}, @submission,
        title : getModuleTitle @submission.moduleKey
  components : {DisplayProblem}
</script>

<style scoped lang="sass">
.date
  font-size : .9em
  color : grey
  margin: 0px
.container
  width: 100%
.problem
  margin-top: -7px
.result
  flex-grow : 1
  background-color : #555
  color : lime
  font-size : 1.1em
  padding : 10px
  margin : 4px 2px 7px 2px
.flex
  display: flex
  justify-content: space-evenly
  align-items: center
.icon
  font-size: 1.4em
  width : 2em
  text-align: center
</style>
