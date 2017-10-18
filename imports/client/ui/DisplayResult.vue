<template lang="jade">
.result-container
  h4 {{$t('deineAntwort')}}:
  katex(v-bind:tex="data.answerTeX")
  h4 {{$t('musterlösung')}}:
  katex(v-bind:tex="data.solutionTeX")
  h4 {{$t('auswertung')}}:
  .result-header.pass(v-if="data.result.pass") {{$t('ergebnisIstKorrekt')}}:
  .result-header.fail(v-else) {{$t('ergebnisIstNichtKorrekt')}}:
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
import Katex from "/imports/client/ui/Katex.vue"
return
  props : ["data"]
  components : { Katex }
</script>

<style scoped lang="sass">
.result-header
  font-size : 1.2em
  color : white
  padding : 10px
.fail
  background-color : #FF4949
.pass
  background-color : #13CE66
</style>
