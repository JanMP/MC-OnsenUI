<template lang="jade">
v-ons-toolbar
  .center {{title}}
  .left
    v-ons-back-button(v-if="showBackButton")
  .right
    v-ons-toolbar-button.collapsing
      v-ons-icon(icon="fa-bars" @click="toggleMenu")
</template>

<script lang="coffee">
return

  methods :
    toggleMenu : ->
      console.log @$store.state.menu.selected
      @$store.commit "menu/toggle"
  props :
    title : String
    showBackButton :
      type : Boolean
      default : -> false
</script>

<style scoped lang="sass">
.collapsing
  @media screen and (min-width : 768px)
    display: none
</style>
