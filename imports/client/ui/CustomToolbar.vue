<template lang="jade">
v-ons-toolbar
  .center {{title}}
  .left
    v-ons-back-button(v-if="showBackButton")
  .right
    v-ons-toolbar-button
      v-ons-icon(icon="fa-bars" @click="toggleMenu")
</template>

<script lang="coffee">
return
  computed :
    showBackButton : ->
      @$store.state.menu.selected is "modules" and @$store.state.navigator.stack.length > 1
  methods :
    toggleMenu : ->
      console.log @$store.state.menu.selected
      @$store.commit "menu/toggle"
  props : ["title"]
</script>

<style scoped lang="sass">
</style>
