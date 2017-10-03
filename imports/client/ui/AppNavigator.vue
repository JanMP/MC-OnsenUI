<template lang="jade">
v-ons-navigator(swipeable
  v-bind:page-stack="pageStack"
  v-bind:pop-page="storePop"
  v-bind:options="options")
</template>

<script lang="coffee">
import ModuleList from "./ModuleList.vue"
return
  beforeCreate : ->
    @$store.commit "navigator/push", ModuleList
  computed :
    pageStack : -> @$store.state.navigator.stack
    options : -> @$store.state.navigator.options
  methods :
    storePop : ->
      @$store.commit "navigator/pop"
</script>

<style scoped lang="sass">
</style>
