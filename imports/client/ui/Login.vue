<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title")
  p
  div(v-if="currentUser")
    UserSettingsPage(v-bind:userId="currentUser._id")
    .container
      p Signed-in als {{currentUser.username}}
      v-ons-button(@click="signOut") Sign-Out
  div(v-else)
    v-ons-list
      v-ons-list-item
        .left
          v-ons-checkbox(v-model="signingIn")
        .center
          label Ich habe bereits ein Benutzerkonto
    p
    v-ons-list-header Login Daten
    v-ons-list
      v-ons-list-item
        .left
          v-ons-icon(fixed-width icon="fa-user")
        .center
          v-ons-input(v-model="userData.username" type="text" placeholder="Benutzername" input-id="usernameId")
      v-ons-list-item(v-if="!signingIn")
        .left
          v-ons-icon(fixed-width icon="fa-envelope")
        .center
          v-ons-input(v-model="userData.email" type="email" input-id="emailId" placeholder="E-Mail")
      v-ons-list-item
        .left
          v-ons-icon(fixed-width icon="fa-key")
        .center
          v-ons-input(v-model="userData.password" type="password" placeholder="Password" input-id="passwordId")
    p
    v-ons-button(v-if="signingIn" modifier="large" @click="signIn") Sign-In
    v-ons-button(v-else modifier="large" @click="signUp") Benutzerkonto einrichten
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
  computed :
    currentUser : -> @$store.state.auth.user
    title : -> if @currentUser then "Einstellungen" else "Sign-In"
  components : { UserSettingsPage }
</script>

<style scoped lang="sass">
.container
  padding : 20px
</style>
