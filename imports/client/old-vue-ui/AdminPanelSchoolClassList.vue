<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="$t('klassen')")
  v-ons-fab.plus-button(@click="newSchoolClass" position="bottom right" v-bind:visible="true")
    v-ons-icon(icon="fa-plus")
    //- span(style="margin-left : 10px")
  v-ons-list-title {{$t('klassen')}}
  v-ons-list
    admin-panel-school-class-list-item(v-for="schoolClass in schoolClasses" v-bind:schoolClass="schoolClass" v-bind:key="schoolClass._id")
</template>

<script lang="coffee">
import AdminPanelSchoolClassListItem from "./AdminPanelSchoolClassListItem.vue"
import AdminSchoolClassSettingsPage from "./AdminSchoolClassSettingsPage.vue"
import { SchoolClasses } from "/imports/api/schoolClasses.coffee"
return
  methods :
    newSchoolClass: ->
      @$store.commit "adminPanelSchoolClassNavigator/unselectSchoolClass"
      @$store.commit "adminPanelSchoolClassNavigator/push", AdminSchoolClassSettingsPage
  meteor :
    schoolClasses : ->
      SchoolClasses.find {},
        sort :
          name : 1
  components : {AdminPanelSchoolClassListItem, AdminSchoolClassSettingsPage}
</script>

<style scoped lang="sass">
.plus-button
  background-color: grey
.clearing
  clear : both
</style>
