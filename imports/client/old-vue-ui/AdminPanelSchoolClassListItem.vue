<template lang="jade">
v-ons-list-item(@click="editSchoolClass")
  .left
    v-ons-icon.class-icon(fixed-width icon="fa-users")
  .center
    div
      span.school-class {{schoolClass.name}}<br>
      span.teacher-name {{teacherFullName}}
</template>

<script lang="coffee">
import AdminSchoolClassSettingsPage from "./AdminSchoolClassSettingsPage.vue"
return
  props :
    schoolClass : Object
    required : true
  meteor :
    teacher :
      params : ->
        id : @schoolClass.teacherId
      update : ({id}) ->
        Meteor.users.findOne(_id : id)
  methods :
    editSchoolClass : ->
      @$store.commit "adminPanelSchoolClassNavigator/selectSchoolClass",  @schoolClass._id
      @$store.commit "adminPanelSchoolClassNavigator/push",  AdminSchoolClassSettingsPage
  computed :
    teacherFullName : ->
      if @teacher.profile?.firstName? and @teacher.profile?.lastName?
        "#{@teacher.profile.firstName} #{@teacher.profile.lastName}"
      else
        if @teacher?
          @$t "keinLehrerName"
        else
          @$t "keinLehrerEintrag"
  components : {AdminSchoolClassSettingsPage}
</script>

<style scoped lang="sass">
.class-icon
  font-size : 1.5em
  color : #444
.school-class
  font-weight: bold
.teacher-name
  color : grey
  font-size : .9em
.red
  color : red
</style>
