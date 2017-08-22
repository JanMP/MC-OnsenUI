<template lang="jade">
v-ons-page
  custom-toolbar(title="Meine Statistik")
  .container
    p Aufgaben gelöst : {{submissions.length}}
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
return
  data : ->
    test : 4
  meteor :
    submissions : -> Submissions.find(userId : Meteor.userId()).fetch()
</script>

<style scoped lang="sass">
.container
  padding : 10px
</style>
