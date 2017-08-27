<template lang="jade">
div(v-if="currentUser")
  .container
    p Signed-in als {{currentUser.username}}
    el-button(type="primary" @click="signOut") Sign-Out
div(v-else)
  el-form(ref="form" v-bind:model="userData" label-width="120px")
    el-form-item(label="")
      el-checkbox(v-model="signingIn") Ich habe bereits ein Benutzerkonto
    el-form-item(label="Benutzername")
      el-input(v-model="userData.username" placeholder="Ein kurzer Benutzername")
    el-form-item(label="E-Mail" v-if="!signingIn")
      el-input(v-model="userData.email" placeholder="Deine E-Mail Adresse" type="email")
    el-form-item(label="Password")
      el-input(v-model="userData.password" placeholder="Password" type="password")
    el-form-item
      el-button(v-if="signingIn" type="primary" @click="signIn") Sign-In
      el-button(v-else type="primary" @click="signUp") Benutzerkonto einrichten
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
      .then null, (reason) =>
        @$alert reason, "Fehler",
          type : "error"
    signUp : ->
      @$store.dispatch "createUser", @userData
      .then null, (reason) => @$alert reason, "Fehler",
        type : "error"
    signOut : ->
      @$store.dispatch "logoutUser"
  computed :
    currentUser : -> @$store.state.auth.user
</script>

<style scoped lang="sass">
</style>
