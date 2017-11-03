<template lang="jade">
v-ons-page
  custom-toolbar(title="Test")
  .test
    function-plot-display(v-bind:data="testData")
  input(v-model="fktStr" @keyup.enter="updateFkt")
  button(@click="decXMin") xMin -
  button(@click="incXMin") xMin +
</template>

<script lang="coffee">
import FunctionPlotDisplay from "./FunctionPlotDisplay.vue"
import math from "mathjs"
return
  data : ->
    fktStr : "(x-1)^2-1"
    testData :
      data : [
        fn : "(x-1)^2-1"
      ]
      xAxis :
        label : "x"
        domain : [-7, 4]
      yAxis :
        label : "f(x)"
        domain : [-3, 5]
      grid : true
  methods :
    decXMin : -> @testData.xAxis.domain.splice 0, 1,  @testData.xAxis.domain[0]-1
    incXMin : -> @testData.xAxis.domain.splice 0, 1,  @testData.xAxis.domain[0]+1
    updateFkt : ->
      try
        math.parse(@fktStr)
        @testData.data[0].fn = @fktStr
      catch error
        console.log error
  components : { FunctionPlotDisplay }
</script>

<style scoped lang="sass">
.test
  box-sizing: border-box
  width: 100%
  border: 1pt solid red
  margin: auto
  transition : all 2s
</style>
