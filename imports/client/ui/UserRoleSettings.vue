<template lang="jade">
div
  v-ons-list-title {{$t('benutzerRollen')}}
  v-ons-list
    v-ons-list-item(v-for="(role, $index) in roles" v-bind:key="role.role")
      label.left
        v-ons-checkbox(
          v-bind:input-id="'checkbox-' + $index"
          v-bind:value="role.role"
          v-model="checkedRoles"
        )
      label.center(v-bind:for="'checkbox-' + $index") {{role.description}}
</template>

<script lang="coffee">
import { setRoleOnOff } from "/imports/api/users.coffee"
import _ from "lodash"
return
  props :
    userId : String
    required : true
  data : ->
    checkedRoles : []
    savedRoles : []
    oldCheckedRoles : []
  computed :
    roles : ->
      allRoles = [
        role : "admin"
        description : @$t "hatAdminRechte"
      ,
        role : "mentor"
        description : @$t "istLehrer"
      ,
        role : "mayNotEditOwnProfile"
        description : @$t "profilGesperrt"
      ]
      _.filter allRoles, (role) => @mayEdit(role.role)
  meteor :
    savedRoles :
      params : -> userId : @userId
      update : ({userId}) ->
        Meteor.users.findOne(userId).roles ? []
  methods :
    loadCheckedRoles : ->
      @oldCheckedRoles = @checkedRoles = @savedRoles
    mayEdit : (role) ->
      unless "admin" in @$store.state.auth.user.roles
        return false
      if (role is "admin")
        unless "superAdmin" in @$store.state.auth.user.roles
          return false
        if @userId is @$store.state.auth.user._id
          return false
      return true
  created : -> @loadCheckedRoles()
  watch :
    savedRoles : -> @loadCheckedRoles()
    checkedRoles : ->
      unless _.isEqual @checkedRoles , @oldCheckedRoles
        for role in @roles
          console.log role, @mayEdit role.role
          if @mayEdit role.role
            setRoleOnOff.call
              userId : @userId
              role : role.role
              isOn : role.role in @checkedRoles
</script>

<style scoped lang="sass">
</style>
