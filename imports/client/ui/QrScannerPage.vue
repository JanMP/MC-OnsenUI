<template lang="jade">
v-ons-page
  custom-toolbar(title="Test")
  v-ons-button(@click="getCode" modifier="large") get QR Code
</template>

<script lang="coffee">
import { Meteor } from "meteor/meteor"
import { setUserSchoolClass } from "/imports/api/users.coffee"
import QRCode from "qrcode-svg"
return
  data : -> {}
  methods :
    getCode : ->
      unless @isCordova
        alert "Cordova only"
        @$store.commit "menu/select", "teacherPanel"
      else
        onSuccess = (codeString) ->
          codeObject = JSON.parse codeString
          unless codeObject?.id? and codeObject?.username?
            alert "Data Error"
          else
            setUserSchoolClass.call
              userId : codeObject.id
              schoolClassId : @schoolClassId
            @$store.commit "menu/select", "teacherPanel"
        onError = (err) -> console.log err
        options =
          flash : "off"
          drawSight : false
        cloudSky.zBar.scan options, onSuccess, onError
  computed :
    isCordova : -> Meteor.isCordova
    schoolClassId : -> @$store.state.teacherPanelNavigator.schoolClassId
</script>

<style scoped lang="sass">
</style>
