<template lang="jade">
v-ons-splitter
  v-ons-splitter-side.side(swipeable v-bind:animation="animation" collapse="(max-width : 767px)" width="200px" side="right" v-bind:open.sync="showMenu")
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
    qr-code-page(v-if="selected === 'qrCodePage'")
    qr-scanner-page(v-if="selected === 'qrScannerPage'")
    function-plot-test-page(v-if="selected === 'functionPlotTestPage'")
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
import QrCodePage from "./QrCodePage.vue"
import FunctionPlotTestPage from "./FunctionPlotTestPage.vue"
return
  created : ->
    @$ons.disableAutoStatusBarFill()
  meteor :
    $subscribe :
      userOwnData : []
      teachersData : []
      schoolClasses : []
  computed :
    animation : ->
      if @$ons.platform.isIOS() then "reveal" else "overlay"
    showMenu :
      get : -> @$store.state.menu.showMenu
      set : (newValue) -> @$store.commit "menu/toggle", newValue
    selected : -> @$store.state.menu.selected
  components : { MenuPage, AppNavigator, CustomToolbar, Info, Login, UserStatisticsPage, AdminPanelUserNavigator, AdminPanelSchoolClassNavigator, TeacherPanelNavigator, QrCodePage, FunctionPlotTestPage }
</script>

<style lang="sass">
.side
  @media screen and (min-width : 768px)
    border-left: 1pt solid silver
.text-container
  padding : 10px
h1, h2, h3, h4, h5, h6
  margin : 0
  padding : 0
.button-group
  .button
    margin-right : 3px
$success: #19be6b
$warning : #ff9900
$error: #ed3f14
.fail, .error
  &.text
    color: $error
  &.back
    background-color: $error
  &.glow
    box-shadow: 0px 0px 10px 2px $error
  &.stroke
    stroke: $error
  &.fill
    fill : $error
.pass, .success
  &.text
    color: $success
  &.back
    background-color: $success
  &.glow
    box-shadow: 0px 0px 10px 2px $success
  &.stroke
    stroke: $success
  &.fill
    fill : $success
.warning
  &.text
    color: $warning
  &.back
    background-color: $warning
  &.glow
    box-shadow: 0px 0px 10px 2px $warning
  &.stroke
    stroke: $warning
.content-box
  padding: 20px
  background-color: white
  // border: 1pt solid silver
  box-shadow: 1px 1px 2px silver
  border-radius: 5px
  flex-shrink: 1
.separated
  margin-bottom: 8px
.spin-container
  width: 100%
  height: 100%
  display: inline-block
  position: relative
.heading
  font-weight: bold
  color: #464c5b
  font-size: 16px
  &.sub
    font-size: 14px
  &.small
    font-size: 12px
.text
  color: #657180
  font-size: 12px
  &.help
    color: #9ea7b4
  &.disabled
    color: #c3cbd6
  &.link
    color: #3399ff
.list-enter-active
  transition: all .7s
.list-leave-active
  transition: all .5s
  position: absolute
.list-enter, .list-leave-to
  opacity: 0
  transform: translateX(300)
.list-move
  transition: all .6s
</style>
