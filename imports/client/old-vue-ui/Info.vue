<template lang="jade">
v-ons-page
  custom-toolbar(title="News")
  .container
    news
</template>

<script lang="coffee">
import News from "/imports/client/ui/News.vue"
return
  components : { News }
</script>

<style scoped lang="sass">
.container
  padding : 10px
</style>
