<template lang="jade">
.result-display-container
  h4 Deine Antwort:
  math-display(v-bind:math="data.answerTeX")
  h4 Musterlösung:
  math-display(v-bind:math="data.solutionTeX")
  h4 Auswertung:
  .result-header.pass(v-if="data.result.pass") Das Ergebnis ist korrekt:
  .result-header.fail(v-else) Das Ergebnis ist nicht korrekt:
  v-ons-list
    v-ons-list-item(v-for="text in data.result.passTextsRequired" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon(icon="fa-check" style="color : green" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.passTextsOptional" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon(icon="fa-check" style="color : green" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.failTextsRequired" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon(icon="fa-times" style="color : red" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.failTextsOptional" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon(icon="fa-times" style="color : red" size="24px" fixed-width)
</template>

<script lang="coffee">
import MathDisplay from "./MathDisplay.vue"
return
  data : ->
    test : "Test 123123"
  props : ["data"]
  components : { MathDisplay }
</script>

<style scoped lang="sass">
.result-display-container
  padding : 10px
.result-header
  font-size : 1.2em
  color : white
  padding : 10px
.fail
  background-color : red
.pass
  background-color : green
</style>
