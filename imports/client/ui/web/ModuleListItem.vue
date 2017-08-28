<template lang="jade">
div
  .module-list-header(v-if="hasChildren")
    h2 {{item.title}}
    .text-regular {{item.description}}
  .list-item(v-else @click="selectModule")
    .item-title
      h3 {{item.title}}
    .item-description.text-regular(v-if="item.description") {{item.description}}
  .list(v-if="hasChildren")
    module-list-item(
      v-for="(subItem, index) in item.kindred"
      v-bind:item="subItem"
      v-bind:key="subItem.moduleKey || index")
</template>

<script scoped lang="coffee">
return
  computed :
    hasChildren : -> @item.kindred?.length > 0
  methods :
    selectModule : ->
      @$router.push
        name : "problem"
        params :
          moduleKey : @item.moduleKey
  props : ['item']
</script>

<style scoped lang="sass">
.module-list-header
  margin : 5px 0 5px 0
  padding : 10px
  background-color : #58B7FF
  color : white
  h2
    margin : 0
.list-item
  display : block
  padding : 10px
  cursor : pointer
  &:hover
    background-color : #D3DCE6
.item-title
  margin : 0
  padding : 0
  h3
    margin : 0

.item-description
</style>
