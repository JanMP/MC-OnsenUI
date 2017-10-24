<template lang="jade">
v-ons-page(modifier="full_bg")
  custom-toolbar(title="Test")
  div(v-html="qrCodeSVG")
  v-ons-button(@click="getCode" modifier="large") get QR Code
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
        options =
          flash : "off"
          drawSight : false
        try
          cloudSky.zBar.scan {}, onSuccess, onError
        catch error
          @error = error
  computed :
    scanningString : -> if @scanning then "on" else "off"
    isCordova : -> Meteor.isCordova
    qrCodeSVG : ->
      user = @$store.state.auth.user
      code = if user?._id?
        JSON.stringify
          id : user._id
          username : user.username
          fullName :
            if user?.profile?.firstName and user?.profile?.lastName
              "#{user.profile.firstName} #{user.profile.lastName}"
      else
        "fnord"
      qr.imageSync code, type : "svg"
</script>

<style scoped lang="sass">
.red
  color: red
</style>
