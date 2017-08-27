<template lang="jade">
.container
  display-problem(v-bind:problem="problem")
  el-form(v-if="!answered" v-bind:inline="true")
    el-form-item(label="Antwort")
      el-input(v-model="answer")
    el-form-item
      el-button(type="primary" @click="submit(answer)") OK
  div(v-else)
    el-button(type="primary" @click="getNewProblem") Neue Aufgabe
</template>

<script lang="coffee">
import DisplayProblem from "/imports/client/ui/common/DisplayProblem.vue"
import problemMixin from "/imports/client/ui/common/Problem.mixin.coffee"
return
  mixins : [problemMixin]
  computed :
    moduleKey : -> @$route.params.moduleKey
  components : { DisplayProblem }
</script>

<style scoped lang="sass">
</style>
