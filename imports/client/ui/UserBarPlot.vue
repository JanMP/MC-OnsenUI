<template lang="jade">
.ct-chart.ct-perfect-fourth(ref="chart")
</template>

<script lang="coffee">
import Chartist from "chartist"
import _ from "lodash"
return
  data : ->
    responsiveOptions : [
      [
        "screen and (orientation:portrait)"
      ,
        horizontalBars: true
      ]
    ]
  computed :
    chartData : ->
      labelFormat = "D.M."
      submissions = @submissions.map (submission) ->
        date :
          moment(submission.date)
          .startOf("day")
          .format(labelFormat)
        answerCorrect : submission.answerCorrect
      labels = []
      series1 = []
      series2 = []
      for daysAgo in [15..0]
        date =
          moment()
          .subtract(daysAgo, "days")
          .startOf("day")
          .format(labelFormat)
        submissionsThatDay =
          _(submissions)
          .filter date : date
          .countBy (submission) -> submission.answerCorrect
          .value()
        labels.push date
        series1.push submissionsThatDay[true] ? 0
        series2.push submissionsThatDay[false] ? 0
      #return
      labels : labels
      series : [series1, series2]
  methods :
    renderChart : ->
      chartOptions = Object.assign {}, @options,
        stackBars : true
        axisY :
          onlyInteger : true
      new Chartist.Bar @$refs.chart, @chartData, chartOptions, @responsiveOptions
  watch :
    chartData : -> @renderChart()
    options : -> @renderChart()
  mounted : -> @renderChart()
  props : ["submissions", "options"]
</script>

<style lang="sass">
.ct-series-a .ct-bar
  stroke: #13CE66
.ct-series-b .ct-bar
  stroke: #FF4949
</style>
