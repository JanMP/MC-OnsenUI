<template lang="jade">
.container
  el-card.box-card
    div(slot="header")
      h3 Ergebnisse der letzten 8 Wochen
    submissions-list(v-bind:submissions="submissions")
  el-card.box-card
    div(slot="header")
      h3 Aktivität in den letzten 14 Tagen
    user-bar-plot(v-bind:submissions="submissions")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
import UserBarPlot from "/imports/client/ui/common/UserBarPlot.vue"
import SubmissionsList from "/imports/client/ui/web/SubmissionsList.vue"
import _ from "lodash"
return
  meteor :
    submissions : ->
      Submissions.find(userId : Meteor.userId()).fetch()
  computed :
    total : -> @submissions.length
    correct : ->
      @submissions
      .filter (submission) -> submission.answerCorrect
      .length
    percentCorrect : ->
      if @total > 0
        " ≈ #{Math.round @correct/@total*100}%"
      else
        ""
  components : { UserBarPlot, SubmissionsList }
</script>

<style scoped lang="sass">
.container
  padding : 10px
  width : 100%
  max-width : 800px
  h2
    margin-top : 10px
    margin-bottom : 10px
.box-card + .box-card
  margin-top : 10px
</style>
