<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="$t('inhalt')")
  module-list-item(v-bind:item="moduleList[0]")
</template>

<script lang="coffee">
import { getModulesList } from '/imports/mathProblems/getModulesList.coffee'
import ModuleListItem from './ModuleListItem.vue'
return
  data : ->
    moduleList : getModulesList(@$store.state.locale.language)
  components : { ModuleListItem }
</script>

<style scoped lang="sass">
</style>
