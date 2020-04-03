<template lang="jade">
v-ons-navigator(swipeable
  v-bind:page-stack="pageStack"
  v-bind:pop-page="storePop"
  v-bind:options="options"
  )
</template>

<script lang="coffee">
import AdminPanelSchoolClassList from "./AdminPanelSchoolClassList.vue"
return
  beforeCreate : ->
    @$store.commit "adminPanelSchoolClassNavigator/push", AdminPanelSchoolClassList
  computed :
    pageStack : -> @$store.state.adminPanelSchoolClassNavigator.stack
    options : -> @$store.state.adminPanelSchoolClassNavigator.options
  methods :
    storePop : ->
      @$store.commit "adminPanelSchoolClassNavigator/pop"
</script>

<style scoped lang="sass">
</style>
