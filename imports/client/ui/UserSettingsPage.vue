<template lang="jade">
div(v-if="userId")
  user-personal-settings(v-bind:userId="userId")
  user-school-class-settings(v-bind:userId="userId")
v-ons-page(v-else)
  custom-toolbar(v-bind:title="$t('fehler')")
  h3 {{$t('nichtAngemeldet')}}
</template>

<script lang="coffee">
import UserPersonalSettings from "./UserPersonalSettings.vue"
import UserSchoolClassSettings from "./UserSchoolClassSettings.vue"
import { roles } from "./mixins/roles.coffee"
return
  mixins : [roles]
  computed :
    userId : -> @currentUser._id
  components : {UserPersonalSettings, UserSchoolClassSettings}
</script>

<style scoped lang="sass">
</style>
