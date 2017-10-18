<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
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
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionListItem from "./SubmissionListItem.vue"
import UserBarPlot from "./UserBarPlot.vue"
return
  data : ->
    student : {}
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
  computed :
    title : -> @student.fullName()
  meteor :
    student :
      params : -> id : @$store.state.teacherPanelNavigator.studentId
      update : ({id}) ->
        Meteor.users.findOne _id : id
    submissions :
      params : -> userId : @student._id
      update : ({userId}) ->
        Submissions.find {userId},
          sort :
            date : -1
        .fetch()
  components : {SubmissionListItem, UserBarPlot}
</script>

<style scoped lang="sass">
.container
  padding: 10px
</style>
