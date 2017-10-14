<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title")
  v-ons-tabbar(
    v-bind:tabs="tabs"
    v-bind:index.sync="activeIndex")
</template>

<script lang="coffee">
import AdminPanelUserNavigator from "./AdminPanelUserNavigator.vue"
import AdminPanelSchoolClassNavigator from "./AdminPanelSchoolClassNavigator.vue"
return
  data : ->
    options :
      animation : "none"
    activeIndex : 0
    tabs : [
      label : "Klassen"
      icon : "fa-users"
      page : AdminPanelUserNavigator
    ,
      label : "Benutzer"
      icon : "fa-user-o"
      page : AdminPanelSchoolClassNavigator
    ]
  computed :
    title : -> @tabs[@activeIndex].label
</script>

<style scoped lang="sass">
</style>
