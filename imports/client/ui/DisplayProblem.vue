<template lang="jade">
.problem-display-container
  h3 {{problem.title}}
  p {{problem.description}}
  katex(v-if="!problem.skipExpression" v-bind:tex="problem.problemTeX")
  div(style="text-align : center")
    geometry-draw-display(v-if="drawSVG" v-bind:data="problem.geometryDrawData")
    function-plot-display(v-if="drawFunctionPlot" v-bind:data="problem.functionPlotData")
  span(v-if="problem.hint") {{problem.hint}}
</template>

<script lang="coffee">
import Katex from "./Katex.vue"
import GeometryDrawDisplay from "./GeometryDrawDisplay.vue"
import FunctionPlotDisplay from "./FunctionPlotDisplay.vue"
return
  computed :
    drawSVG : -> @problem?.geometryDrawData?
    drawFunctionPlot : -> @problem?.functionPlotData?
  props : ["problem"]
  components : { Katex, GeometryDrawDisplay, FunctionPlotDisplay }
</script>

<style scoped lang="sass">
.problem-display-container
  padding : 10px
</style>
