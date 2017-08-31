<template lang="jade">
div
  el-dialog(title="Ergebnis" v-bind:visible.sync="dialogVisible")
    display-submission(v-bind:submission="selectedSubmission")

  data-tables(
    v-bind:data="pimpedSubmissions"
    v-bind:table-props="tableProps"
    v-bind:search-def="searchDef"
    v-bind:pagination-def="paginationDef"
    @row-click="onRowClick"
  )
    el-table-column(
      label="Datum" prop="date" sortable="custom" v-bind:formatter="dateFormatter"
    )
    el-table-column(
      label="Modul" prop="moduleTitle" sortable="custom"
    )
    el-table-column(
      label="Level" prop="level" sortable="custom"
    )
    el-table-column(
      label="Ergebnis" prop="answerCorrect" sortable="custom"
      v-bind:formatter="answerCorrectFormatter"
    )
</template>

<script lang="coffee">
import DisplaySubmission from "/imports/client/ui/common/DisplaySubmission.vue"
import { getModuleTitle } from "/imports/client/mathproblems/getModulesList.coffee"
return
  data : ->
    selectedSubmission : {}
    dialogVisible : false
    tableProps :
      border : false
      defaultSort :
        prop : "date"
        order : "descending"
    searchDef :
      props : ["moduleTitle"]
    paginationDef :
      pageSize : 10
      pageSizes : [10, 20, 50, 100, 500]
  computed :
    pimpedSubmissions : ->
      @submissions.map (submission) ->
        submission.moduleTitle = getModuleTitle submission.moduleKey
        submission
  methods :
    dateFormatter : (row) ->
      moment(row.date).fromNow()
    answerCorrectFormatter : (row) ->
      if row.answerCorrect then "Korrekt" else "Nicht Korrekt"
    onRowClick : (row) ->
      @selectedSubmission = row
      @dialogVisible = true
  props : ["submissions"]
  components : { DisplaySubmission }
</script>

<style scoped lang="sass">
</style>
