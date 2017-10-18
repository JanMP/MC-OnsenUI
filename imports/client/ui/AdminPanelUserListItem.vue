<template lang="jade">
v-ons-list-item(@click="selectUser")
  .left
    v-ons-icon(fixed-width v-bind:class="icon.className" v-bind:style="{color : userColor}" v-bind:icon="icon.name")
  .center
    div
      span.fullName(v-if="user.profile && user.profile.firstName && user.profile.lastName") {{user.profile.firstName}} {{user.profile.lastName}}
      span.username ({{user.username}})<br>
      span(v-if="user.lastActive") {{$t('zuletztAktiv')}}: {{timeAgo}}<br>
      span.klasse(v-if="showSchoolClass") {{$t('klasse')}}: {{schoolClassName}}
</template>

<script lang="coffee">
import AdminUserSettingsPage from "./AdminUserSettingsPage.vue"
import {SchoolClasses} from "/imports/api/schoolClasses.coffee"
return
  props :
    user : Object
    required : true
  data : ->
    schoolClassName : ""
  methods :
    selectUser : ->
      @$store.commit "adminPanelUserNavigator/selectUser", @user._id
      @$store.commit "adminPanelUserNavigator/push", AdminUserSettingsPage
  computed :
    timeAgo : -> moment(@user.lastActive).fromNow()
    icon : ->
      if "mentor" in (@user.roles ? [])
        className : "teacherIcon"
        name : "fa-graduation-cap"
      else
        className : "studentIcon"
        name : "fa-user"
    showSchoolClass : ->
      ("mentor" not in (@user.roles ? [])) and @schoolClassName?
    userColor : ->
      unless @user?.lastActive?
        return "grey"
      moreThanDaysAgo = (days) =>
        moment(@user.lastActive).isBefore moment().subtract(days, "days")
      switch
        when moreThanDaysAgo 7 then "red"
        when moreThanDaysAgo 3 then "orange"
        else "green"
  meteor :
    schoolClassName :
      params : ->
        id : @user.schoolClassId
      update : ({id}) -> (SchoolClasses.findOne _id : id)?.name
</script>

<style scoped lang="sass">
.teacherIcon
  font-size : 1.4em
.studentIcon
  font-size : 1.6em
.fullName
  font-weight: bold
  margin-right: .5em
.username
  font-style: italic
</style>
