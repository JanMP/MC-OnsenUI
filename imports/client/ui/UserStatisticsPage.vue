<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="$t('meineErgebnisse')")
  .content(ref="content")
    user-bar-plot(v-bind:submissions="submissions" v-bind:options="chartOptions")
    p
    v-ons-list-header {{$t('einzelergebnisse')}}
    v-ons-list
      v-ons-list-item(v-if="submissions.length === 0")
        .center {{$t('keineErgebnisse')}}
      submission-list-item(v-for="submission in submissions" v-bind:key="submission._id" v-bind:submission="submission")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
import UserBarPlot from "/imports/client/ui/UserBarPlot.vue"
import SubmissionListItem from "./SubmissionListItem.vue"
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
    submissions : ->
      Submissions.find userId : Meteor.userId(),
        sort :
          date : -1
      .fetch()
  components : { UserBarPlot, SubmissionListItem }
</script>

<style scoped lang="sass">
.container
  padding : 10px
</style>
