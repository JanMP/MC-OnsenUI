<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
  v-ons-list-title Schüler
  v-ons-list
    teacher-panel-student-list-item(v-for="student in students" v-bind:key="student._id" v-bind:student="student")
</template>

<script lang="coffee">
import TeacherPanelStudentListItem from "./TeacherPanelStudentListItem.vue"
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
return
  data : ->
    students : []
    schoolClass : {}
  computed :
    schoolClassId : -> @$store.state.teacherPanelNavigator.schoolClassId
    title : -> "Klasse #{@schoolClass?.name}"
  meteor :
    schoolClass :
      params : -> schoolClassId : @schoolClassId
      update : ({schoolClassId}) ->
        SchoolClasses.findOne _id : schoolClassId
    students :
      params : ->
        schoolClassId : @schoolClassId
      update : ({schoolClassId}) -> (Meteor.users.find {schoolClassId}).fetch()
  components : { TeacherPanelStudentListItem }
</script>

<style scoped lang="sass">
.class-icon
  font-size : 1.4em
</style>
