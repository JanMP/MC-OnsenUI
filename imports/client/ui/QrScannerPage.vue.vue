<template lang="jade">
v-ons-page(modifier="full_bg")
  custom-toolbar(title="Test")
  p
  v-ons-button(@click="getCode") get QR Code
  div(v-html="qrCodeSVG")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import qr from "qr-image"
return
  data : ->
    error : ""
    svg : ""
  methods :
    getCode : ->
      unless @isCordova
        alert "Cordova only"
      else
        onSuccess = (text) -> alert text
        onError = (err) -> console.log err
        try
          cloudSky.zBar.scan {}, onSuccess, onError
        catch error
          @error = error
    QrCode : ->
      user = @$store.state.auth.user
      unless user._id?
        alert "User ist nicht angemeldet."
        return
      code = JSON.stringify
        id : user._id
        username : user.username
        fullName :
          if user?.profile?.firstName and user?.profile?.lastName
            "#{user.profile.firstName} #{user.profile.lastName}"
      @svg = qr.imageSync code, type : "svg"
  computed :
    scanningString : -> if @scanning then "on" else "off"
    isCordova : -> Meteor.isCordova
    qrCodeSVG : ->
      user = @$store.state.auth.user
      code = if user._id?
        JSON.stringify
          id : user._id
          username : user.username
          fullName :
            if user?.profile?.firstName and user?.profile?.lastName
              "#{user.profile.firstName} #{user.profile.lastName}"
      else
        ""
      qr.imageSync code, type : "svg"
</script>

<style scoped lang="sass">
.red
  color: red
</style>
