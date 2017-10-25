<template lang="jade">
div
  v-ons-list-header {{$t('persönlicheDaten')}}
  v-ons-list
    v-ons-list-item
      .center
        v-ons-input(v-model="formData.firstName" type="text" v-bind:placeholder="$t('vorname')" input-id="firstNameId")
    v-ons-list-item
      .center
        v-ons-input(v-model="formData.lastName" type="text" v-bind:placeholder="$t('nachname')" input-id="lastNameId")
    v-ons-button(modifier="large" @click="submitUserData" v-bind:disabled="!dataChanged") {{$t('speichern')}}
</template>

<script lang="coffee">
import { setUserSchoolClass, updateUserProfile } from "/imports/api/users.coffee"
import { SchoolClasses, saveSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  props :
    userId : String
  data : ->
    user : {}
    formData :
      firstName : ""
      lastName : ""
  meteor :
    user :
      params : -> id : @userId
      update : ({id}) ->
        Meteor.users.findOne(id)
  methods :
    setFormData : ->
      @formData.firstName = @user?.profile?.firstName
      @formData.lastName = @user?.profile?.lastName
    submitUserData : ->
      profile = Object.assign @user?.profile ? {},
        firstName : @formData.firstName
        lastName : @formData.lastName
      updateUserProfile.call
        profile : profile
        userId : @user?._id
  computed :
    dataChanged : ->
      @formData.firstName isnt @user?.profile?.firstName or
      @formData.lastName isnt @user?.profile?.lastName
  created : -> @setFormData()
  watch :
    user : -> @setFormData()
</script>

<style scoped lang="sass">
.container
  padding : 0px 10px
</style>
