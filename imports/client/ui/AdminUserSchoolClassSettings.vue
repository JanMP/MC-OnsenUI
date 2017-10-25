<template lang="jade">
div
  v-ons-list-header {{$t('klasseLerngruppe')}}
  v-ons-list(v-if="isTeacher")
    v-ons-list-item
      .center {{$t('alsLehrerEingetragen')}}
  v-ons-list(v-else)
    v-ons-list-item(v-for="(schoolClass, $index) in schoolClasses" v-bind:key="schoolClass._id")
      .left
        v-ons-radio(
          v-bind:input-id="'radio-' + $index"
          v-bind:value="schoolClass._id"
          v-model="formData.schoolClassId"
        )
      label.center(v-bind:for="'radio-' + $index") {{schoolClass.name}}
    v-ons-button(modifier="large" @click="submitUserData" v-bind:disabled="!dataChanged") {{$t('speichern')}}
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
    schoolClasses : []
    user : {}
    formData :
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
        Meteor.users.findOne(id)
  methods :
    setFormData : ->
      @formData.schoolClassId = @user?.schoolClassId
    submitUserData : ->
      setUserSchoolClass.call
        userId : @user?._id
        schoolClassId : @formData.schoolClassId
  computed :
    isTeacher : -> Roles.userIsInRole @user?._id, "mentor"
    dataChanged : ->
      @formData.schoolClassId isnt @user?.schoolClassId
  created : -> @setFormData()
  watch :
    user : -> @setFormData()

</script>

<style scoped lang="sass">
.container
  padding : 0px 10px
</style>
