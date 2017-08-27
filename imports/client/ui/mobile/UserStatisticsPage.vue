<template lang="jade">
v-ons-page
  custom-toolbar(title="Meine Statistik")
  .container
    p Aufgaben gelöst : {{submissions.length}}
    user-bar-plot
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
import UserBarPlot from "./UserBarPlot.vue"
return
  meteor :
    submissions : -> Submissions.find(userId : Meteor.userId()).fetch()
  components : { UserBarPlot }
</script>

<style scoped lang="sass">
.container
  padding : 10px
</style>
