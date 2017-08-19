<template lang="jade">
div(ref="pretty")
</template>

<script lang="coffee">
return
  mounted : ->
    @$refs.pretty.innerHTML = "$$#{@math}$$"
    MathJax.Hub.Queue ["Typeset", MathJax.Hub, @$refs.pretty]
  watch :
    math : ->
      pretty = MathJax.Hub.getAllJax(@$refs.pretty)[0]
      MathJax.Hub.Queue ["Text", pretty, @math]
  props : ["math"]
</script>

<style scoped lang="sass">
</style>
