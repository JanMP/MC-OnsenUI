<template lang="jade">
.result-container
  h4 {{$t('deineAntwort')}}:
  katex(v-bind:tex="data.answerTeX")
  h4 {{$t('musterlösung')}}:
  katex(v-bind:tex="data.solutionTeX")
  h4 {{$t('auswertung')}}:
  .result-header.pass.back(v-if="data.result.pass") {{$t('ergebnisIstKorrekt')}}:
  .result-header.fail.back(v-else) {{$t('ergebnisIstNichtKorrekt')}}:
  v-ons-list
    v-ons-list-item(v-for="text in data.result.passTextsRequired" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon.pass.text(icon="fa-check" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.passTextsOptional" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon.pass.text(icon="fa-check" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.failTextsRequired" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon.fail.text(icon="fa-times" size="24px" fixed-width)
    v-ons-list-item(v-for="text in data.result.failTextsOptional" key="text" modifier="nodivider")
      .center {{text}}
      .left
        v-ons-icon.fail.text(icon="fa-times" size="24px" fixed-width)
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
</style>
