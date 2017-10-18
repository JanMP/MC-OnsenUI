<template lang="jade">
v-ons-page
  custom-toolbar(v-bind:title="title" v-bind:showBackButton="true")
  v-ons-list-header {{$t('nameDerKlasse')}}
  v-ons-list
    v-ons-list-item
      .center
        v-ons-input(v-model="formData.name" type="text" placeholder="Name der Klasse" input_id="name")
  v-ons-list-header {{$t('lehrer')}}
  v-ons-list
    v-ons-list-item(v-for="(teacher, $index) in teachers" v-bind:key="teacher._id")
      .left
        v-ons-radio(
          v-bind:input-id="'radio-' + $index"
          v-bind:value="teacher.id"
          v-model="formData.teacherId"
        )
      label.center(v-bind:for="'radio-' + $index") {{teacher.name}}
  p
    v-ons-button(modifier="large" @click="submitSchoolClassData" v-bind:disabled="!dataChanged") {{$t('speichern')}}
    v-ons-button.danger(modifier="large" @click="deleteSchoolClass") {{$t('klasseLöschen')}}
</template>

<script lang="coffee">
import { SchoolClasses, saveSchoolClass, deleteSchoolClass } from "/imports/api/schoolClasses.coffee"
return
  data : ->
    formData :
      _id : ""
      name : ""
      teacherId : ""
    schoolClass :
      _id : ""
      name : ""
      teacherId : ""
    teachers : []
  meteor :
    schoolClass :
      params : -> id : @schoolClassId
      update : ({id}) ->
        unless id is ""
          SchoolClasses.findOne _id : id
        else
          name : ""
          teacherId : ""
    teachers : ->
      Roles.getUsersInRole "mentor"
        .fetch().map (e)->
          id : e._id
          name :
            if e?.profile?.lastName? and e?.profile?.firstName?
              "#{e.profile.lastName}, #{e.profile.firstName}"
            else
              e?.username ? "Fehler. Kein Name oder Username."
  methods :
    closePage : -> @$store.commit "adminPanelSchoolClassNavigator/pop"
    setFormData : ->
      @formData = Object.assign {}, @schoolClass
    submitSchoolClassData : ->
      saveSchoolClass.call @formData
      @closePage()
    deleteSchoolClass : ->
      @$ons.notification.confirm @$t "klasseLöschenNachfragen"
      .then =>
        deleteSchoolClass.call id : @schoolClass?._id
        @closePage()

  computed :
    schoolClassId : -> @$store.state.adminPanelSchoolClassNavigator.schoolClassId
    newSchoolClass : -> @schoolClassId is ""
    title : ->
      unless @newSchoolClass
        @schoolClass?.name
      else
        @$t "neueKlasse"
    dataChanged : ->
      @formData.name isnt @schoolClass?.name or
      @formData.teacherId isnt @schoolClass?.teacherId
  created : -> @setFormData()
  watch :
    schoolClass : -> @setFormData()
</script>

<style scoped lang="sass">
.danger
  background-color: red
</style>
