<template lang="jade">
v-ons-page
  custom-toolbar(title="Benutzer Verwalten")
  v-ons-list-title Benutzer
  v-ons-list
    admin-panel-user-list-item(
      v-for="user in users"
      v-bind:key="user._id"
      v-bind:user="user"
    )
</template>

<script lang="coffee">
import AdminPanelUserListItem from "./AdminPanelUserListItem.vue"
return
  data : ->
    users : []
  meteor :
    users : ->
      Meteor.users.find {},
        sort :
          "profile.lastName" : 1
          "profile.firstName" : 1
          "username" : 1
      .fetch()
  components : {AdminPanelUserListItem}
</script>

<style scoped lang="sass">
.container
  padding: 10px
</style>
