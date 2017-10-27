<template lang="jade">
v-ons-page
  custom-toolbar(title="$t('inhalt')")
  module-list-item(v-bind:item="moduleList[0]")
</template>

<script lang="coffee">
import { getModulesList } from '/imports/client/mathproblems/getModulesList.coffee'
import ModuleListItem from './ModuleListItem.vue'
return
  data : ->
    moduleList : getModulesList(@$store.state.locale.language)
  components : { ModuleListItem }
</script>

<style scoped lang="sass">
</style>
