<template lang="jade">
v-ons-page
  custom-toolbar(title="Meine Statistik")
  .content.container(ref="content")
    user-bar-plot(v-bind:submissions="submissions" v-bind:options="chartOptions")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
import UserBarPlot from "/imports/client/ui/UserBarPlot.vue"
return
  data : ->
    chartOptions : {}
  mounted : ->
    window.addEventListener "resize", @setChartOptions
    @$nextTick @setChartOptions
  beforeDestroy : ->
    window.removeEventListener "resize", @setChartOptions
  methods :
    setChartOptions : ->
      if e = @$refs.content
        @chartOptions =
          width : "#{e.clientWidth-20}px"
          height : "#{e.clientHeight-20}px"
  meteor :
    submissions : -> Submissions.find(userId : Meteor.userId()).fetch()
  components : { UserBarPlot }
</script>

<style scoped lang="sass">
.container
  padding : 10px
</style>
