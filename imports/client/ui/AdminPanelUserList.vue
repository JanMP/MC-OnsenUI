<template lang="jade">
v-ons-page
  custom-toolbar(title="Benutzer Verwalten")
  v-ons-list-title Benutzer
  v-ons-list
    v-ons-list-item(v-for="user in users" v-bind:key="user._id" @click="selectUser(user._id)" v-bind:selectedUserId="user._id")
      .left
        v-ons-icon(fixed-width icon="fa-user")
      .center
        span.fullName(v-if="user.profile && user.profile.firstName && user.profile.lastName") {{user.profile.firstName}} {{user.profile.lastName}}
        span ({{user.username}})
</template>

<script lang="coffee">
import AdminUserSettingsPage from "./AdminUserSettingsPage.vue"
return
  methods :
    selectUser : (userId) ->
      @$store.commit "adminPanelUserNavigator/selectUser", userId
      @$store.commit "adminPanelUserNavigator/push", AdminUserSettingsPage
  meteor :
    users : ->
      Meteor.users.find {},
        sort :
          "profile.lastName" : 1
          "profile.firstName" : 1
          "username" : 1
      .fetch()
</script>

<style scoped lang="sass">
.container
  padding : 10px
.fullName
  margin-right : .5em
</style>
