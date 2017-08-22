<template lang="jade">
.menu
  v-ons-list-title Einstellungen
  v-ons-list
    v-ons-list-item(@click="select('login')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-sign-in")
      .center Sign-In
      .right
        v-ons-icon(icon="fa-angle-right")
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-user")
      .center Persönliche Daten
      .right
        v-ons-icon(icon="fa-angle-right")
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-cogs")
      .center Einstellungen
      .right
        v-ons-icon(icon="fa-angle-right")
  v-ons-list-title Funktionen
  v-ons-list
    v-ons-list-item(@click="select('modules')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-list")
      .center Aufgaben
      .right
        v-ons-icon(icon="fa-angle-right")
    v-ons-list-item(@click="select('userStatistics')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-bar-chart")
      .center Meine Statistik
      .right
        v-ons-icon(icon="fa-angle-right")
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-comments-o")
      .center Chat
      .right
        v-ons-icon(icon="fa-angle-right")
  v-ons-list-title Für Lehrer
  v-ons-list
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-users")
      .center Meine Klassen
      .right
        v-ons-icon(icon="fa-angle-right")
  v-ons-list-title Information
  v-ons-list
    v-ons-list-item(@click="select('news')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-info-circle")
      .center News
      .right
        v-ons-icon(icon="fa-angle-right")
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-question-circle")
      .center Hilfe
      .right
        v-ons-icon(icon="fa-angle-right")
</template>

<script lang="coffee">
return
  methods :
    select : (str) ->
      @$store.commit "menu/select", str
      @$store.commit "menu/toggle"
</script>

<style scoped lang="sass">
.menu
  background-color : white
  border-right : 1pt solid grey
  height : 100vh
</style>
