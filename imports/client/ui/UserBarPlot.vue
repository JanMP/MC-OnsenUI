<template lang="jade">
.silver
  svg(width="100%" height="100%" v-bind:viewBox="chartData.viewbox" preserveAspectRatio="none")
    //- rect(x="0" y="0" v-bind:width="chartData.width" v-bind:height="chartData.height")
    g(v-for="entry in chartData.barData")
      line(
        v-bind:x1="entry.x"
        v-bind:y1="entry.greenY1"
        v-bind:x2="entry.x"
        v-bind:y2="entry.greenY2"
        style="stroke:green; stroke-width:9")
      line(
        v-bind:x1="entry.x"
        v-bind:y1="entry.greenY2"
        v-bind:x2="entry.x"
        v-bind:y2="entry.redY2"
        style="stroke:red; stroke-width:9")
</template>

<script lang="coffee">
#TODO: show max value in barplot
import Chartist from "chartist"
import _ from "lodash"
return
  data : ->
    mockDayData : [15..0].map (daysAgo) ->
      correctCount : daysAgo
      falseCount : 30-2*daysAgo
      totalCount : 30-daysAgo

  computed :
    chartData : ->
      labelFormat="D.M."
      submissions = @submissions.map (submission) ->
        date :
          moment submission.date
          .startOf "day"
          .format labelFormat
        answerCorrect : submission.answerCorrect
      dayData = [15..0].map (daysAgo) ->
        date =
          moment()
          .subtract daysAgo, "days"
          .startOf("day")
          .format(labelFormat)
        submissionsCorrectThatDay =
          _(submissions)
          .filter {date}
          .countBy (submission) -> submission.answerCorrect
          .value()
        correctCount = submissionsCorrectThatDay[true] ? 0
        falseCount = submissionsCorrectThatDay[false] ? 0
        totalCount = correctCount + falseCount
        return {date, daysAgo, correctCount, falseCount, totalCount}
      #dayData = @mockDayData
      maxDayTotal = (_.maxBy dayData, "totalCount").totalCount
      viewbox = "0 0 160 #{maxDayTotal * 10}"
      width = 160
      height = maxDayTotal * 10 + 10
      barData = dayData.map (day, index) ->
        x = 5 + index * 10
        greenY1 = maxDayTotal * 10
        greenY2 = greenY1 - day.correctCount * 10
        redY2 = greenY2 - day.falseCount * 10
        {x, greenY1, greenY2, redY2}
      {barData, viewbox, width, height}
  props : ["submissions", "options"]
</script>

<style scoped lang="sass">
.silver
  box-sizing : border-box
  background-color: #333
  padding : 5px
  width: 100%
  height : 200px
</style>
