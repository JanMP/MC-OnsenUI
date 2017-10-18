<template lang="jade">
v-ons-list-item(@click="selectStudent")
  .left
    v-ons-icon.student-icon(fixed-width v-bind:style="{color : iconColor}" icon="fa-user")
  .center
    div
      span.fullName(v-if="student.fullName()") {{student.fullName()}} 
      span.username ({{student.username}})<br>
      span(v-if="student.lastActive") {{$t('zuletztAktiv')}}: {{timeAgo}}<br>
</template>

<script lang="coffee">
import TeacherPanelStudentDetails from "./TeacherPanelStudentDetails.vue"
import {SchoolClasses} from "/imports/api/schoolClasses.coffee"
return
  props :
    student : Object
    required : true
  data : ->
    schoolClassName : ""
  methods :
    selectStudent : ->
      @$store.commit "teacherPanelNavigator/selectStudent", @student._id
      @$store.commit "teacherPanelNavigator/push", TeacherPanelStudentDetails
  computed :
    timeAgo : -> moment(@student.lastActive).fromNow()
    iconColor : ->
      unless @student?.lastActive?
        return "grey"
      moreThanDaysAgo = (days) =>
        moment(@student.lastActive).isBefore moment().subtract(days, "days")
      switch
        when moreThanDaysAgo 7 then "red"
        when moreThanDaysAgo 3 then "orange"
        else "green"
  meteor :
    schoolClassName :
      params : ->
        id : @student.schoolClassId
      update : ({id}) -> (SchoolClasses.findOne _id : id)?.name
</script>

<style scoped lang="sass">
.student-icon
  font-size: 1.4em
</style>
