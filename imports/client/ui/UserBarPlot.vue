<template lang="jade">
.silver
  svg(width="100%" height="100%" v-bind:viewBox="chartData.viewBox" preserveAspectRatio="none")
    g(v-bind:transform="chartData.coordinateTransform")
      g(v-for="bar in chartData.bars")
        line.moving(
          v-bind:x1="bar.x"
          y1=0
          v-bind:x2="bar.x"
          v-bind:y2="bar.y1Red"
          style="stroke:green; stroke-width:9")
        line.moving(
          v-bind:x1="bar.x"
          v-bind:y1="bar.y1Red"
          v-bind:x2="bar.x"
          v-bind:y2="bar.y2Red"
          style="stroke:red; stroke-width:9")
      //- text(x=0 y=0 font-family="mono" font-size=10 fill="black" transform="scale(0 -1) translate(10 -10)") Test
</template>

<script lang="coffee">
#TODO: show max value in barplot
import Chartist from "chartist"
import _ from "lodash"
return
  data : ->
    daysCharted : 14
    dayWidth : 10
    dayGap : 1
    answerHeight : 10

  computed :
    chartData : ->
      labelFormat="D.M."
      submissions = @submissions.map (submission) ->
        date :
          moment submission.date
          .startOf "day"
          .format labelFormat
        answerCorrect : submission.answerCorrect
      dayData = [@daysCharted-1..0].map (daysAgo) ->
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
      viewBox = "0 0 #{@daysCharted * (@dayWidth)} #{maxDayTotal * 10}"
      coordinateTransform = "translate(0 #{maxDayTotal * 10}) scale(1 -1)"
      bars = dayData.map (day, index) =>
        x : @dayWidth * (index + .5)
        y1Red : @answerHeight * day.correctCount
        y2Red : @answerHeight * (day.correctCount + day.falseCount)
      return {viewBox, coordinateTransform, bars}
  props : ["submissions", "options"]
</script>

<style scoped lang="sass">
.moving
  transition : all 1s
.silver
  box-sizing : border-box
  background-color: none
  padding : 15px 20px 10px 20px
  width: 100%
  height : 200px
</style>
