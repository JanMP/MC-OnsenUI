<template lang="jade">
div
  v-ons-list-header {{$t('klasseLerngruppe')}}
  v-ons-list(v-if="isTeacher")
    v-ons-list-item
      .center {{$t('alsLehrerEingetragen')}}
  v-ons-list(v-else)
    .center.container {{$t('beschreibungQrCode')}}
  v-ons-button(modifier="large" @click="showQrCode") {{$t('umAufnameBitten')}}
</template>

<script lang="coffee">
import { setUserSchoolClass, updateUserProfile } from "/imports/api/users.coffee"
import { SchoolClasses, saveSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  props :
    userId :
      type : String
      required : true
  data : ->
    user : {}
    schoolClass : {}
  meteor :
    schoolClass :
      params : -> id : @user?.schoolClassId
      update : ({id}) ->
        SchoolClasses.findOne _id : id
    user :
      params : -> id : @userId
      update : ({id}) ->
        Meteor.users.findOne _id : id
  methods :
    showQrCode : ->
      @$store.commit "menu/select", "qrCodePage"
  computed :
    isTeacher : -> Roles.userIsInRole @user?._id, "mentor"
</script>

<style scoped lang="sass">
.container
  padding : 10px 10px
</style>
