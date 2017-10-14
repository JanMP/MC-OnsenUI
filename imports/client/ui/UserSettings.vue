<template lang="jade">
div
  v-ons-list-header Persönliche Daten
  v-ons-list
    v-ons-list-item
      .center
        v-ons-input(v-model="formData.firstName" type="text" placeholder="Vorname" input-id="firstNameId")
    v-ons-list-item
      .center
        v-ons-input(v-model="formData.lastName" type="text" placeholder="Nachname" input-id="lastNameId")
  .container(v-if="isTeacher")
    p Als Lehrer eingetragen. Lehrer haben keine Klasse.
  div(v-else)
    v-ons-list-header Klasse/Lerngruppe
    v-ons-list
      v-ons-list-item(v-for="(schoolClass, $index) in schoolClasses" v-bind:key="schoolClass._id")
        .left
          v-ons-radio(
            v-bind:input-id="'radio-' + $index"
            v-bind:value="schoolClass._id"
            v-model="formData.schoolClassId"
          )
        label.center(v-bind:for="'radio-' + $index") {{schoolClass.name}}
  p
    v-ons-button(modifier="large" @click="submitUserData" v-bind:disabled="!dataChanged") Speichern
</template>

<script lang="coffee">
import { setUserSchoolClass, updateUserProfile } from "/imports/api/users.coffee"
import { SchoolClasses, saveSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  props :
    userId : String
  data : ->
    schoolClasses : []
    user : {}
    formData :
      firstName : ""
      lastName : ""
      schoolClassId : ""
    selectedSchoolClassId : ""
  meteor :
    schoolClasses : ->
      SchoolClasses.find {},
        sort :
          name : 1
      .fetch()
    user :
      params : -> id : @userId
      update : ({id}) ->
        console.log "user.update"
        Meteor.users.findOne(id)
  methods :
    setFormData : ->
      @formData.firstName = @user?.profile?.firstName
      @formData.lastName = @user?.profile?.lastName
      @formData.schoolClassId = @user?.schoolClassId
    submitUserData : ->
      profile = Object.assign @user?.profile ? {},
        firstName : @formData.firstName
        lastName : @formData.lastName
      updateUserProfile.call
        profile : profile
        userId : @user?._id
      setUserSchoolClass.call
        userId : @user?._id
        schoolClassId : @formData.schoolClassId
  computed :
    isTeacher : -> Roles.userIsInRole @user?._id, "mentor"
    dataChanged : ->
      @formData.firstName isnt @user?.profile?.firstName or
      @formData.lastName isnt @user?.profile?.lastName or
      @formData.schoolClassId isnt @user?.schoolClassId
  created : -> @setFormData()
  watch :
    user : -> @setFormData()

</script>

<style scoped lang="sass">
.container
  padding : 0px 10px
</style>
