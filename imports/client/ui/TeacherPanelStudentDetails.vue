<template lang="jade">
v-ons-page(v-bind:infinite-scroll="loadMore")
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true" v-bind:gravatar="student")
  .content(ref="content")
    user-bar-plot(v-bind:user="student")
    p
    v-ons-list-header {{$t('einzelergebnisse')}}
    v-ons-list
      v-ons-list-item(v-if="submissions.length === 0")
        .center {{$t('keineErgebnisse')}}
      submission-list-item(v-for="submission in submissions" v-bind:key="submission._id" v-bind:submission="submission")
      v-ons-list-item(v-if="!$subReady.userSubmissions")
        .center Loading...
</template>

<script lang="coffee">
import { Submissions } from "/imports/api/submissions.coffee"
import SubmissionListItem from "./SubmissionListItem.vue"
import UserBarPlot from "./UserBarPlot/UserBarPlot.vue"
return
  data : ->
    student : {}
    chartOptions : {}
    page : 1
  mounted : ->
    window.addEventListener "resize", @setChartOptions
    @$nextTick @setChartOptions
  beforeDestroy : ->
    window.removeEventListener "resize", @setChartOptions
  methods :
    loadMore : (done) ->
      if @page * 10 <= @submissions.length then @page += 1
      Vue.nextTick done
  computed :
    title : -> @student?.fullName()
    studentId : -> @$store.state.teacherPanelNavigator.studentId
  meteor :
    $subscribe :
      userData : -> [id : @studentId]
      userSubmissions : -> [
        userId : @studentId
        page : @page
      ]
    student :
      params : -> id : @studentId
      update : ({id}) ->
        Meteor.users.findOne _id : id
    submissions :
      params : -> userId : @studentId
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
