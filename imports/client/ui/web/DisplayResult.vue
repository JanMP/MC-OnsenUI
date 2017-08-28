<template lang="jade">
.result-container
  h4 Deine Antwort:
  katex(v-bind:tex="data.answerTeX")
  h4 Musterlösung:
  katex(v-bind:tex="data.solutionTeX")
  h4 Auswertung:
  .box
    .result-header.pass(v-if="data.result.pass") Das Ergebnis ist korrekt:
    .result-header.fail(v-else) Das Ergebnis ist nicht korrekt:
    .fail-text(v-for="text in data.result.passTextsRequired" key="text")
      icon.icon.pass(name="check")
      |{{text}}
    .fail-text(v-for="text in data.result.passTextsOptional" key="text")
      icon.icon.pass(name="check")
      |{{text}}
    .fail-text(v-for="text in data.result.failTextsRequired" key="text")
      icon.icon.fail(name="times")
      |{{text}}
    .fail-text(v-for="text in data.result.failTextsOptional" key="text")
      icon.icon.warn(name="times")
      |{{text}}
</template>

<script lang="coffee">
import Katex from "/imports/client/ui/common/Katex.vue"
return
  props : ["data"]
  components : { Katex }
</script>

<style scoped lang="sass">
.box
  border : 1px solid grey
  box-shadow : 2px 2px 2px silver
  margin-top : 10px
.result-container
  margin-top : 1em
  margin-bottom : 2em
.result-header
  font-size : 1.2em
  color : white
  padding : 10px
  &.fail
    background-color : #FF4949
  &.pass
    background-color : #13CE66
.fail-text
  padding : 10px 10px 10px 20px
.icon
  width : 1.3em
  height : 1.3em
  margin-right : 20px
  &.fail
    color : #FF4949
  &.pass
    color : #13CE66
  &.warn
    color : #F7BA2A
</style>
