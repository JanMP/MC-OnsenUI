<template lang="jade">
div
  h3 {{problem.title}}
  p {{problem.description}}
  katex(v-if="!problem.skipExpression" v-bind:tex="problem.problemTeX")
  .center
    geometry-draw-display(v-if="drawSVG" v-bind:data="problem.geometryDrawData")
    function-plot-display(v-if="drawFunctionPlot" v-bind:data="problem.functionPlotData")
  span(v-if="problem.hint") {{problem.hint}}
</template>

<script lang="coffee">
import Katex from "/imports/client/ui/common/Katex.vue"
import GeometryDrawDisplay from "/imports/client/ui/common/GeometryDrawDisplay.vue"
import FunctionPlotDisplay from "/imports/client/ui/common/FunctionPlotDisplay.vue"
return
  computed :
    drawSVG : -> @problem?.geometryDrawData?
    drawFunctionPlot : -> @problem?.functionPlotData?
  props : ["problem"]
  components : { Katex, GeometryDrawDisplay, FunctionPlotDisplay }
</script>

<style scoped lang="sass">
.center
  text-align : center
</style>
