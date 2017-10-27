import { Meteor } from "meteor/meteor"
import { setUserSchoolClass } from "/imports/api/users.coffee"
import QRCode from "qrcode-svg"

export addStudentToSchoolClass =
  methods :
    addStudentToSchoolClass : (schoolClassId) ->
      unless Meteor.isCordova
        alert "Only works in native mobile app"
      else
        onSuccess = (codeString) =>
          codeObject = JSON.parse codeString
          unless codeObject?.id? and codeObject?.username?
            alert "Data Error"
          else
            setUserSchoolClass.call
              userId : codeObject.id
              schoolClassId : schoolClassId
        onError = (err) -> console.log err
        options =
          flash : "off"
          drawSight : false
        cloudSky.zBar.scan options, onSuccess, onError
