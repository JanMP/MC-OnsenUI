<template lang="jade">
.menu
  v-ons-list-title {{$t('einstellungen')}}
  v-ons-list
    v-ons-list-item(v-if="$store.state.auth.user" @click="select('login')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-cogs")
      .center {{$t('einstellungen')}}
    v-ons-list-item(v-else @click="select('login')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-sign-in")
      .center {{$t('anmelden')}}
  v-ons-list-title {{$t('fürSchüler')}}
  v-ons-list
    v-ons-list-item(@click="select('modules')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-list")
      .center {{$t('aufgaben')}}
    v-ons-list-item(@click="select('userStatistics')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-bar-chart")
      .center {{$t('meineErgebnisse')}}
    //- v-ons-list-item
    //-   .left
    //-     v-ons-icon.list-item__icon(fixed-width icon="fa-comments-o")
    //-   .center {{$t('chat')}}
  v-ons-list-title(v-if="isTeacher") {{$t('fürLehrer')}}
  v-ons-list(v-if="isTeacher")
    v-ons-list-item(@click="select('teacherPanel')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-graduation-cap")
      .center {{$t('meineKlassen')}}
  v-ons-list-title(v-if="isAdmin") {{$t('verwalten')}}
  v-ons-list(v-if="isAdmin")
    v-ons-list-item(@click="select('userList')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-wrench")
      .center {{$t('benutzer')}}
    v-ons-list-item(@click="select('schoolClassList')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-wrench")
      .center {{$t('klassen')}}
  v-ons-list-title {{$t('information')}}
  v-ons-list
    v-ons-list-item(@click="select('news')")
      .left
        v-ons-icon.list-item__icon(fixed-width icon="fa-info-circle")
      .center {{$t('news')}}
    //- v-ons-list-item(@click="select('functionPlotTestPage')")
    //-   .left
    //-     v-ons-icon.list-item__icon(fixed-width icon="fa-line-chart")
    //-   .center {{$t('funktionsgraph')}}
    //- v-ons-list-item
    //-   .left
    //-     v-ons-icon.list-item__icon(fixed-width icon="fa-question-circle")
    //-   .center {{$t('hilfe')}}
</template>

<script lang="coffee">
import { roles } from "./mixins/roles.coffee"
return
  mixins : [roles]
  methods :
    select : (str) ->
      @$store.commit "menu/select", str
      @$store.commit "menu/toggle"
</script>

<style scoped lang="sass">
.menu
  background-color : white
  height : 100vh
.red
  color : red
</style>
