<template lang="jade">
v-ons-page
  v-ons-splitter
    v-ons-splitter-side(swipeable collapse="" width="200px" side="right" animation="reveal" v-bind:open.sync="showMenu")
      menu-page
    v-ons-splitter-content
      app-navigator(v-show="selected === 'modules'")
      info(v-if="selected === 'news'")
      login(v-if="selected === 'login'")
      user-statistics-page(v-if="selected === 'userStatistics'")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import CustomToolbar from "./CustomToolbar.vue"
import MenuPage from "./Menu.vue"
import AppNavigator from "./AppNavigator.vue"
import Info from "./Info.vue"
import Login from "./Login.vue"
import UserStatisticsPage from "./UserStatisticsPage.vue"
return
  created : ->
    @$ons.disableAutoStatusBarFill()
  computed :
    showMenu :
      get : -> @$store.state.menu.showMenu
      set : (newValue) -> @$store.commit "menu/toggle", newValue
    selected : -> @$store.state.menu.selected
  components : { MenuPage, AppNavigator, CustomToolbar, Info, Login, UserStatisticsPage}
</script>

<style scoped lang="sass">
.container
  text-align : center
  margin : 20px auto 0 auto
.button-group
  .button
    margin-right : 3px
</style>
