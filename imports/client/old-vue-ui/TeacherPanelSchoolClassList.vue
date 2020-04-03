<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="$t('meineKlassen')")
  v-ons-list-title {{$t('klassen')}}
  v-ons-list
    teacher-panel-school-class-list-item(v-for="schoolClass in schoolClasses" v-bind:schoolClass="schoolClass" v-bind:key="schoolClass._id")
</template>

<script lang="coffee">
import TeacherPanelSchoolClassListItem from "./TeacherPanelSchoolClassListItem.vue"
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
return
  data : ->
    schoolClasses : []
  meteor :
    schoolClasses :
      params : -> teacherId : @$store.state.auth.user._id
      update : ({teacherId}) -> (SchoolClasses.find {teacherId}).fetch()
  components : { TeacherPanelSchoolClassListItem }
</script>

<style scoped lang="sass">
.red
  color: red
</style>
