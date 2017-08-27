<template lang="jade">
.ct-chart.ct-perfect-fourth(ref="chart")
</template>

<script lang="coffee">
import Chartist from "chartist"
import "chartist/dist/chartist.css"
return
  data : ->
    chartData :
      labels : ["Lesen", "Schreiben", "Rechnen"]
      series : [
        [20, 14, 23]
      ]
  mounted : ->
    new Chartist.Bar @$refs.chart, @chartData
</script>

<style scoped lang="sass">
</style>
