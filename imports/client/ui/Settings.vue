<template lang="jade">
div
  p Trage bitte deinen Vor- und Nachnamen ein und wähle deine Schulklasse oder Lerngruppe aus.
  v-ons-list-header Persönliche Daten
  v-ons-list
    v-ons-list-item
      .center
        v-ons-input(v-model="userData.firstName" type="text" placeholder="Vorname" input-id="firstNameId")
    v-ons-list-item
      .center
        v-ons-input(v-model="userData.lastName" type="text" placeholder="Nachname" input-id="lastNameId")
  div(v-if="isTeacher")
    p Du bist als Lehrer eingetragen. Lehrer haben keine Schulklasse (Schüler haben Schulklassen und Schulklassen haben Lehrer)
  div(v-else)
    v-ons-list-header Klasse/Lerngruppe
    v-ons-list
      v-ons-list-item(v-for="(schoolClass, $index) in schoolClasses")
        .left
          v-ons-radio(
            v-bind:input-id="'radio-' + $index"
            v-bind:value="schoolClass._id"
            v-model="userData.schoolClassId"
          )
        label.center(v-bind:for="'radio-' + $index") {{schoolClass.name}}
  p
    v-ons-button(modifier="large" @click="submitUserData" v-bind:disabled="!dataChanged") Speichern
</template>

<script lang="coffee">
import { setUserSchoolClass, updateUserProfile } from "/imports/api/users.coffee"
import { SchoolClasses, saveSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  data : ->
    userData :
      firstName : ""
      lastName : ""
      schoolClassId : ""
    selectedSchoolClassId : ""
  meteor :
    schoolClasses : ->
      SchoolClasses.find {},
        sort :
          name : 1
  methods :
    setUserData : ->
      @userData.firstName = @currentUser?.profile?.firstName
      @userData.lastName = @currentUser?.profile?.lastName
      @userData.schoolClassId = @currentUser?.schoolClassId
    submitUserData : ->
      profile = Object.assign @currentUser?.profile ? {},
        firstName : @userData.firstName
        lastName : @userData.lastName
      updateUserProfile.call
        profile : profile
        userId : @currentUser?._id
      setUserSchoolClass.call
        userId : @currentUser?._id
        schoolClassId : @userData.schoolClassId
  computed :
    currentUser : -> @$store.state.auth.user
    isTeacher : -> Roles.userIsInRole @currentUser._id, "mentor"
    isAdmin : -> Roles.userIsInRole @currentUser._id, "admin"
    dataChanged : ->
      @userData.firstName isnt @currentUser?.profile?.firstName or
      @userData.lastName isnt @currentUser?.profile?.lastName or
      @userData.schoolClassId isnt @currentUser?.schoolClassId
  created : -> @setUserData()
  watch :
    currentUser : -> @setUserData()

</script>

<style scoped lang="sass">
.container
  padding : 20px
</style>
