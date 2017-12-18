<template lang="jade">
v-ons-page(v-bind:infinite-scroll="loadMore")
  custom-toolbar(v-bind:title="$t('meineErgebnisse')")
  .content(ref="content")
    v-ons-list-header {{$t('zweiWochenÜbersicht')}}
    .bar-plot.container
      user-bar-plot(v-bind:user="user")
    v-ons-list-header {{$t('einzelergebnisse')}}
    v-ons-list
      v-ons-list-item(v-if="submissions.length === 0")
        .center {{$t('keineErgebnisse')}}
      submission-list-item(v-for="submission in submissions" v-bind:key="submission._id" v-bind:submission="submission")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { Submissions } from "/imports/api/submissions.coffee"
import UserBarPlot from "/imports/client/ui/UserBarPlot/UserBarPlot.vue"
import SubmissionListItem from "./SubmissionListItem.vue"
return
  data : ->
    page : 1
  methods :
    loadMore : (done) ->
      if @page * 10 <= @submissions.length then @page += 1
      Vue.nextTick done
  meteor :
    $subscribe :
      userSubmissions : -> [
        userId : @$store.state.auth.user._id
        page : @page
      ]
    user : -> Meteor.users.findOne Meteor.userId()
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
.bar-plot-container
  width : 200px
  height : 200px
</style>
