<template lang="jade">
v-ons-list-item(@click="selectSchoolClass")
  .left
    v-ons-icon.class-icon(fixed-width icon="fa-users")
  .center
    div
      span.class-name {{schoolClass.name}}<br>
      span Schüler: {{students.length}}
</template>

<script lang="coffee">
import TeacherPanelStudentList from "./TeacherPanelStudentList.vue"
return
  props :
    schoolClass :
      type : Object
      required : true
  data : ->
    students : []
  methods :
    selectSchoolClass : ->
      @$store.commit "teacherPanelNavigator/selectSchoolClass", @schoolClass._id
      @$store.commit "teacherPanelNavigator/push", TeacherPanelStudentList
  meteor :
    students :
      params : -> schoolClassId : @schoolClass._id
      update : ({schoolClassId}) -> (Meteor.users.find {schoolClassId}).fetch()
</script>

<style scoped lang="sass">
.class-icon
  font-size : 1.4em
.class-name
  font-weight: bold
</style>
