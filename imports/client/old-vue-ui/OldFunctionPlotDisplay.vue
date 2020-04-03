<template lang="jade">
div(ref="target")
</template>

<script lang="coffee">
import { Random } from "meteor/random"
#deal with the frigging mess that is function-plot:
window.d3 = require "d3"
functionPlot = require "function-plot"
return
  data : ->
    id : ""
  methods :
    options : ->
      Object.assign {}, @data,
        target : "##{@id}"
        width : 240
        height : 240
        disableZoom : true
  mounted : ->
    @id = Random.id()
    @$refs.target.id = @id
    functionPlot @options()
  watch :
    data : -> functionPlot @options()
  props : ["data"]
</script>

<style scoped lang="sass">
</style>
