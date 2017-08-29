<template lang="jade">
div
  el-dialog(
    title="Ergebnis"
    v-bind:visible.sync="dialogVisible"
  )
    display-submission(v-bind:submission="selectedSubmission")
  data-tables(
    v-bind:data="submissions"
    v-bind:table-props="tableProps"
    v-bind:search-def="searchDef"
    v-bind:pagination-def="paginationDef"
    @row-click="onRowClick"
  )
    el-table-column(
      label="Datum" prop="date" sortable="custom" v-bind:formatter="dateFormatter"
    )
    el-table-column(
      label="Modul" prop="moduleKey" sortable="custom"
      v-bind:formatter="moduleTitle"
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
      props : ["moduleKey"]
    paginationDef :
      pageSize : 10
      pageSizes : [10, 20, 50, 100, 500]
  computed :
    tableData : ->
      start = (@currentPage-1)*@pageSize
      end=Math.min @currentPage*@pageSize, @submissions.length-1
      console.log start, end
      @submissions[start..end]
  methods :
    dateFormatter : (row) ->
      moment(row.date).fromNow()
    moduleTitle : (row) -> getModuleTitle row.moduleKey
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
