<template lang="jade">
v-ons-page
  v-ons-splitter
    v-ons-splitter-side(swipeable collapse="" width="200px" side="right" animation="reveal" v-bind:open.sync="showMenu")
      menu-page
    v-ons-splitter-content
      app-navigator
</template>

<script lang="coffee">
import CustomToolbar from "./CustomToolbar.vue"
import MenuPage from "./Menu.vue"
import AppNavigator from "./AppNavigator.vue"
return
  created : ->
    @$ons.disableAutoStatusBarFill()
  computed :
    showMenu :
      get : -> @$store.state.menu.showMenu
      set : (newValue) -> @store.commit "menu/toggle", newValue
  components : { MenuPage, AppNavigator, CustomToolbar }

</script>

<style scoped lang="sass">
.container
  text-align : center
  margin : 20px auto 0 auto
.button-group
  .button
    margin-right : 3px

</style>
