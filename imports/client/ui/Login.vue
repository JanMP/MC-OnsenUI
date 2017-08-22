<template lang="jade">
v-ons-page
  custom-toolbar(title="Sign-In")
  p
  div(v-if="currentUser")
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
    signUp : ->
      @$store.dispatch "createUser", @userData
    signOut : ->
      @$store.dispatch "logoutUser"
  computed :
    currentUser : -> @$store.state.auth.user
</script>

<style scoped lang="sass">
.container
  padding : 20px
</style>
