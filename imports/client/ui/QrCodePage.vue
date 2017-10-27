<template lang="jade">
v-ons-page
  custom-toolbar(title="Test")
  div(ref="svg" v-html="svg")
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import QRCode from "qrcode-svg"
return
  data : ->
    svg : ""
    oldSchoolClassId : ""
  mounted : ->
    @ldSchoolClassId = @$store.state.auth.user.schoolClassId
    @svg = @qrCodeSVG()
    Vue.nextTick =>
      console.log ele = @$refs.svg.childNodes[2]
      ele.setAttribute "viewBox", "0 0 256 256"
      ele.setAttribute "width", "100%"
      ele.removeAttributeNode ele.getAttributeNode "height"
  methods :
    qrCodeSVG : ->
      user = @$store.state.auth.user
      code =
        if user?._id?
          JSON.stringify
            id : user._id
            username : user.username
            fullName :
              if user?.profile?.firstName and user?.profile?.lastName
                "#{user.profile.firstName} #{user.profile.lastName}"
        else
          "fnord"
      new QRCode(code).svg()
  computed :
    currentSchoolClassId : -> @$store.state.auth.user.schoolClassId
  watch :
    currentSchoolClassId : -> @$store.commit "menu/select", "login"

</script>

<style scoped lang="sass">
#qrcode
  width : 100%
</style>
