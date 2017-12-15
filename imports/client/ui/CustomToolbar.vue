<template lang="jade">
v-ons-toolbar
  .center
    .level
      info-avatar(v-if="gravatar" v-bind:user="gravatar" size=20).margin
      span {{title}}
  .left
    v-ons-back-button(v-if="showBackButton")
  .right
    v-ons-toolbar-button.collapsing
      v-ons-icon(icon="fa-bars" @click="toggleMenu")
</template>

<script lang="coffee">
import InfoAvatar from "./InfoAvatar.vue"
return
  methods :
    toggleMenu : ->
      console.log @$store.state.menu.selected
      @$store.commit "menu/toggle"
  props :
    title : String
    gravatar :
      type : Object
      optional : true
    showBackButton :
      type : Boolean
      default : -> false
  components : { InfoAvatar }
</script>

<style scoped lang="sass">
.margin
  margin-right: 8px
.level
  display: flex
  align-items: center
  justify-content: flex-start
.collapsing
  @media screen and (min-width : 768px)
    display: none
</style>
