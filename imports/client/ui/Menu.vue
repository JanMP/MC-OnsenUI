<template lang="jade">
.menu
  v-ons-list-title Einstellungen
  v-ons-list
    v-ons-list-item(v-if="$store.state.auth.user" @click="select('login')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-cogs")
      .center Einstellungen
    v-ons-list-item(v-else @click="select('login')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-sign-in")
      .center Login
  v-ons-list-title Funktionen
  v-ons-list
    v-ons-list-item(@click="select('modules')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-list")
      .center Aufgaben
    v-ons-list-item(@click="select('userStatistics')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-bar-chart")
      .center Meine Statistik
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-comments-o")
      .center Chat
  v-ons-list-title Information
  v-ons-list
    v-ons-list-item(@click="select('news')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-info-circle")
      .center News
    v-ons-list-item
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-question-circle")
      .center Hilfe
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
  height : 100vh
</style>
