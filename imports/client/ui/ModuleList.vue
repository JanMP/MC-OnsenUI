<template lang="jade">
v-ons-page
  custom-toolbar
  module-list-item(v-bind:item="moduleList[0]")
</template>

<script lang="coffee">
import { getModulesList } from '/imports/client/mathproblems/getModulesList.coffee'
import ModuleListItem from './ModuleListItem.vue'
return
  data : ->
    moduleList : getModulesList()
  components : { ModuleListItem }
</script>

<style scoped lang="sass">
</style>
