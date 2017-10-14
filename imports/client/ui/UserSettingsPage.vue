<template lang="jade">
user-settings(v-if="userId" v-bind:userId="userId")
v-ons-page(v-else)
  custom-toolbar(title="Fehler")
  h3 Nicht als Benutzer eingetragen
</template>

<script lang="coffee">
import UserSettings from "./UserSettings.vue"
import { roles } from "./mixins/roles.coffee"
return
  mixins : [roles]
  computed :
    userId : -> @currentUser._id
  components : {UserSettings}
</script>

<style scoped lang="sass">
</style>
