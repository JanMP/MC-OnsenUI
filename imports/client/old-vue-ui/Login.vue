<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title")
  div(v-if="currentUser")
    UserSettingsPage(v-bind:userId="currentUser._id")
    .container
      p {{$t('angemeldetAls')}} {{currentUser.username}}
      v-ons-button(@click="signOut") {{$t('abmelden')}}
  div(v-else)
    v-ons-list
      v-ons-list-item
        .left
          v-ons-checkbox(v-model="signingIn")
        .center
          label {{$t('habeBenutzerkonto')}}
    p
    v-ons-list-header {{$t('loginDaten')}}
    v-ons-list
      v-ons-list-item
        .left
          v-ons-icon(fixed-width icon="fa-user")
        .center
          v-ons-input(v-model="userData.username" type="text" v-bind:placeholder="$t('benutzername')" input-id="usernameId")
      v-ons-list-item(v-if="!signingIn")
        .left
          v-ons-icon(fixed-width icon="fa-envelope")
        .center
          v-ons-input(v-model="userData.email" type="email" input-id="emailId" v-bind:placeholder="$t('eMail')")
      v-ons-list-item
        .left
          v-ons-icon(fixed-width icon="fa-key")
        .center
          v-ons-input(v-model="userData.password" type="password" v-bind:placeholder="$t('password')" input-id="passwordId")
    p
    v-ons-button(v-if="signingIn" modifier="large" @click="signIn") {{$t('anmelden')}}
    v-ons-button(v-else modifier="large" @click="signUp") {{$t('benutzerkontoEinrichten')}}
  .container
    v-ons-button(@click="switchLanguage") {{otherLanguageText}}
</template>

<script lang="coffee">
import UserSettingsPage from "./UserSettingsPage.vue"
return
  data : ->
    userData :
      username : ""
      email : ""
      password : ""
    signingIn : false
  methods :
    signIn : ->
      @$store.dispatch "loginUser", @userData
      .then null, (reason) => @$ons.notification.toast reason, timeout : 2000
    signUp : ->
      @$store.dispatch "createUser", @userData
      .then null, (reason) => @$ons.notification.toast reason, timeout : 2000
    signOut : ->
      @$store.dispatch "logoutUser"
    switchLanguage : ->
      @$store.dispatch "locale/set", @otherLanguage
  computed :
    currentUser : -> @$store.state.auth.user
    title : -> if @currentUser then @$t "einstellungen" else @$t "anmelden"
    otherLanguage : ->
      if @$store.state.locale.language is "en" then "de" else "en"
    otherLanguageText : ->
      switch @otherLanguage
        when "en" then "Zu Englisch wechseln"
        when "de" then "switch to german"
  components : { UserSettingsPage }
</script>

<style scoped lang="sass">
.container
  padding : 20px
</style>
