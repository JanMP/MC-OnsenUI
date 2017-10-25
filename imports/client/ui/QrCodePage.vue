<template lang="jade">
v-ons-page
  custom-toolbar(title="Test")
  div(v-html="qrCodeSVG")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import QRCode from "qrcode-svg"
return
  data : -> {}
  computed :
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
      new QRCode(code).svg()
</script>

<style scoped lang="sass">
</style>
