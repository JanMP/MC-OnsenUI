<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
  user-role-settings(v-bind:userId="userId")
  user-settings(v-bind:userId="userId")
</template>

<script lang="coffee">
import UserSettings from "./UserSettings.vue"
import UserRoleSettings from "./UserRoleSettings.vue"
return
  computed :
    userId : -> @$store.state.adminPanelUserNavigator.userId
    title : -> "Benutzer : #{@user?.username}"
  meteor :
    user :
      params : -> id : @userId
      update : ({id}) -> Meteor.users.findOne(id)
  components : {UserSettings, UserRoleSettings}
</script>

<style scoped lang="sass">
</style>
