<template lang="jade">
v-ons-navigator(swipeable
  v-bind:page-stack="pageStack"
  v-bind:pop-page="storePop"
  v-bind:options="options"
  )
</template>

<script lang="coffee">
import AdminPanelUserList from "./AdminPanelUserList.vue"
return
  beforeCreate : ->
    @$store.commit "adminPanelUserNavigator/push", AdminPanelUserList
  computed :
    pageStack : -> @$store.state.adminPanelUserNavigator.stack
    options : -> @$store.state.adminPanelUserNavigator.options
  methods :
    storePop : ->
      @$store.commit "adminPanelUserNavigator/pop"
</script>

<style scoped lang="sass">
</style>
