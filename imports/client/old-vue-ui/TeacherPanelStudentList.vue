<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
  v-ons-list-title {{$t('schüler')}}
  v-ons-list
    teacher-panel-student-list-item(v-for="student in students" v-bind:key="student._id" v-bind:student="student")
  v-ons-fab.plus-button(position="bottom right" @click="addStudent")
    v-ons-icon(icon="fa-plus")
</template>

<script lang="coffee">
import TeacherPanelStudentListItem from "./TeacherPanelStudentListItem.vue"
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
import { addStudentToSchoolClass } from "./mixins/addStudentToSchoolClass.coffee"
return
  mixins : [addStudentToSchoolClass]
  data : ->
    students : []
    schoolClass : {}
  computed :
    schoolClassId : -> @$store.state.teacherPanelNavigator.schoolClassId
    title : -> @schoolClass?.name
  meteor :
    schoolClass :
      params : -> schoolClassId : @schoolClassId
      update : ({schoolClassId}) ->
        SchoolClasses.findOne _id : schoolClassId
    students :
      params : ->
        schoolClassId : @schoolClassId
      update : ({schoolClassId}) -> (Meteor.users.find {schoolClassId}).fetch()
  methods :
    addStudent : ->
      @addStudentToSchoolClass @schoolClassId
  components : { TeacherPanelStudentListItem }
</script>

<style scoped lang="sass">
.plus-button
  background-color: grey
.class-icon
  font-size : 1.4em
</style>
