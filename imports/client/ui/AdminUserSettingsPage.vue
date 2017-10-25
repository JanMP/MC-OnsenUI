<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
  user-role-settings(v-bind:userId="userId")
  p {{$t('adminUserSettingsHint')}}
  user-personal-settings(v-bind:userId="userId")
  admin-user-school-class-settings(v-bind:userId="userId")
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserRoleSettings from "./UserRoleSettings.vue"
import AdminUserSchoolClassSettings from "./AdminUserSchoolClassSettings.vue"
return
  computed :
    userId : -> @$store.state.adminPanelUserNavigator.userId
    title : -> "#{@$t 'benutzer'}: #{@user?.username}"
  meteor :
    user :
      params : -> id : @userId
      update : ({id}) -> Meteor.users.findOne(id)
  components : {UserPersonalSettings, UserRoleSettings, AdminUserSchoolClassSettings}
</script>

<style scoped lang="sass">
p
  margin-left: 10px
</style>
