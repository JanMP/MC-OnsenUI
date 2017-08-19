<template lang="jade">
v-ons-toolbar
  .center {{title}}
  .left
    v-ons-back-button
  .right
    v-ons-toolbar-button
      v-ons-icon(icon="fa-bars" @click="toggleMenu")
</template>

<script lang="coffee">
return
  computed :
    showBackButton : ->
      @$store.state.navigator.stack.length > 1
  methods :
    toggleMenu : ->
      @$store.commit "menu/toggle"
  props : ["title"]
</script>

<style scoped lang="sass">
</style>
