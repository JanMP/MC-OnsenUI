<template lang="jade">
div
  v-ons-list-header(v-if="hasChildren") {{item.title}}
  v-ons-list-item(v-else @click="selectModule")
    span.list-item__title {{item.title}}
    span.list-item__subtitle(v-if="item.description") {{item.description}} <br>
  v-ons-list(v-if="hasChildren")
    module-list-item(
      v-for="(subItem, index) in item.kindred"
      v-bind:item="subItem"
      v-bind:key="subItem.moduleKey || index")
</template>

<script lang="coffee">
import Problem from "./Problem.vue"
return
  computed :
    hasChildren : -> @item.kindred?.length > 0
  methods :
    selectModule : ->
      if @item.moduleKey
        @$store.commit "navigator/selectModule", @item.moduleKey
        @$store.commit "navigator/push", Problem
  props : ['item']
</script>

<style scoped lang="sass">
</style>
