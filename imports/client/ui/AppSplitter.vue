<template lang="jade">
v-ons-splitter
  v-ons-splitter-side(swipeable v-bind:animation="animation" collapse width="200px" side="right" v-bind:open.sync="showMenu")
    menu-page
  v-ons-splitter-content
    app-navigator(v-if="selected === 'modules'")
    info(v-if="selected === 'news'")
    login(v-if="selected === 'login'")
    user-statistics-page(v-if="selected === 'userStatistics'")
    teacher-panel-navigator(v-if="selected === 'teacherPanel'")
    //- admin-panel-main-page(v-if="selected === 'adminPanel'")
    admin-panel-user-navigator(v-if="selected === 'userList'")
    admin-panel-school-class-navigator(v-if="selected === 'schoolClassList'")
    qr-scanner-page(v-if="selected === 'qrScannerPage'")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import CustomToolbar from "./CustomToolbar.vue"
import MenuPage from "./Menu.vue"
import AppNavigator from "./AppNavigator.vue"
import Info from "./Info.vue"
import Login from "./Login.vue"
import UserStatisticsPage from "./UserStatisticsPage.vue"
import TeacherPanelNavigator from "./TeacherPanelNavigator.vue"
# import AdminPanelMainPage from "./AdminPanelMainPage.vue"
import AdminPanelUserNavigator from "./AdminPanelUserNavigator.vue"
import AdminPanelSchoolClassNavigator from "./AdminPanelSchoolClassNavigator.vue"
import QrScannerPage from "./QrScannerPage.vue"
return
  created : ->
    @$ons.disableAutoStatusBarFill()
  computed :
    animation : ->
      if @$ons.platform.isIOS() then "reveal" else "overlay"
    showMenu :
      get : -> @$store.state.menu.showMenu
      set : (newValue) -> @$store.commit "menu/toggle", newValue
    selected : -> @$store.state.menu.selected
  components : { MenuPage, AppNavigator, CustomToolbar, Info, Login, UserStatisticsPage, AdminPanelUserNavigator, AdminPanelSchoolClassNavigator, TeacherPanelNavigator, QrScannerPage }
</script>

<style lang="sass">
.text-container
  padding : 10px
h1, h2, h3, h4, h5, h6
  margin : 0
  padding : 0
.button-group
  .button
    margin-right : 3px
</style>
