<template lang="jade">
v-ons-navigator(swipeable
  v-bind:page-stack="pageStack"
  v-bind:pop-page="storePop"
  v-bind:options="options"
)
</template>

<script lang="coffee">
import TeacherPanelSchoolClassList from "./TeacherPanelSchoolClassList.vue"
return
  beforeCreate : ->
    @$store.commit "teacherPanelNavigator/init", TeacherPanelSchoolClassList
  computed :
    pageStack : -> @$store.state.teacherPanelNavigator.stack
    options : -> @$store.state.teacherPanelNavigator.options
  methods :
    storePop : ->
      @$store.commit "teacherPanelNavigator/pop"
</script>

<style scoped lang="sass">
.red
  color: red
</style>
