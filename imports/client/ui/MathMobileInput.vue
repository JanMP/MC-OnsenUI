<template lang="jade">
.mobile-input-container
  .display {{beforeCursor}}<span class="cursor">│</span>{{afterCursor}}
  ons-row(v-if="letterKeys")
    ons-col(v-for="key in letterKeys" key="key.symbol" v-bind:width="key.width")
      .button-container
        .math-button(v-bind:class="key.class" @click="processKey(key.symbol)") {{key.symbol}}
  ons-row
    ons-col(width="20%" v-for="key in keys" key="key.symbol")
      .button-container
        .math-button(v-bind:class="key.class" @click="processKey(key.symbol)") {{key.symbol}}
  ons-row.button-container
    ons-col(width="60%")
      ons-row
        ons-col(width="33%")
          .master-button(modifier="large quiet" @click="decLevel") -
        ons-col(width="33%")
          .master-button(modifier="large quiet") Level {{level}}
        ons-col(width="33%")
          .master-button(modifier="large quiet" @click="incLevel") +
    ons-col(width="40%")
      .master-button(modifier="large" @click="submit") {{$t('abgeben')}}
</template>

<script lang="coffee">
#import { teXifyAM } from "/imports/client/mathproblems/renderAM.coffee"
return
  data : ->
    keys : [
      {symbol : "←", class : "control"}, {symbol : "del", class : "control"}, {symbol : "→", class : "control"},
      {symbol : "(", class : "operator"}, {symbol : ")", class : "operator"},
      {symbol : "7", class : "number"}, {symbol : "8", class : "number"}, {symbol : "9", class : "number"},
      {symbol : "/", class : "operator"}, {symbol : "√", class : "operator"},
      {symbol : "4", class : "number"}, {symbol : "5", class : "number"}, {symbol : "6", class : "number"},
      {symbol : "*", class : "operator"}, {symbol : "^", class : "operator"},
      {symbol : "1", class : "number"}, {symbol : "2", class : "number"}, {symbol : "3", class : "number"},
      {symbol : "-", class : "operator"}, {symbol : ",", class : "control"},
      {symbol : "0", class : "number"}, {symbol : ".", class : "operator"}, {symbol : "=", class : "operator"},
      {symbol : "+", class : "operator"}, {symbol : "?", class : "control"}
    ]
    cursorPosition : 0
    answerString : ""
    tickle : 0
  computed :
    beforeCursor : -> @answerString.slice 0, @cursorPosition
    afterCursor : -> @answerString.slice @cursorPosition
    letterKeys : ->
      solutionStr = @solution
      arr = []
      for str in ["sin", "cos", "tan", "cot"]
        newSolutionStr = solutionStr.replace str, ""
        if newSolutionStr isnt solutionStr
          arr.push str
          solutionStr = newSolutionStr
      symbols = arr.concat _.sortBy _.uniq /([a-z])/ig[Symbol.match] solutionStr
      if 0 < (numSymbols = symbols.length)
        @$emit "setHeight", "307px"
        symbols.map (e)->
          symbol : e
          class : "special"
          width : "#{100/numSymbols}%"
      else
        @$emit "setHeight", "275px"
        []
  methods :
    insert : (symbol) ->
      beforeCursor = @answerString.slice 0, @cursorPosition
      afterCursor = @answerString.slice @cursorPosition
      @answerString = beforeCursor.concat symbol, afterCursor
      @cursorPosition = @cursorPosition += symbol.length
    cursorLeft : ->
      if @cursorPosition > 0 then @cursorPosition -= 1
    cursorRight : ->
      if @cursorPosition < @answerString.length then @cursorPosition += 1
    delete : ->
      if @cursorPosition > 0
        before = @answerString.slice 0, @cursorPosition-1
        after = @answerString.slice @cursorPosition
        @answerString = before.concat after
        @cursorPosition -= 1
    processKey : (symbol) ->
      switch symbol
        when "del"
          @delete()
        when "←"
          @cursorLeft()
        when "→"
          @cursorRight()
        when "√"
          @insert "sqrt("
        else
          @insert symbol
    submit : ->
      @$emit "submit", @answerString
    decLevel : ->
      @$emit "decLevel"
    incLevel : ->
      @$emit "incLevel"
  props : ["math", "solution", "level"]
</script>

<style scoped lang="sass">
.mobile-input-container
  padding : 10px
.button-container
  padding : 2px
.math-button
  font-size : 1em
  width : 100%
  padding : 4px 0
  margin : 0
  border : 0
  text-align : center
  // border-radius : 5px
  // box-shadow : 2px 2px 3px grey
.master-button
  font-size : 1.1em
  width : 100%
  padding : 5px 0
  margin : 4px 0 0 0px
  border : 0px
  text-align : center
  background-color : silver
.number
  color : white
  background-color : grey
.operator
  color : black
  background-color : orange
.control
  color : black
  background-color : darkgrey
.special
  color : black
  background-color : lightgrey
.display
  background-color : #555
  color : lime
  font-size : 1.1em
  padding : 10px
  margin : 4px 2px 7px 2px
  // border-radius : 5px
  // box-shadow : inset -1px -1px 8px 1px silver, 2px 2px 2px grey
.cursor
  color : lime
  margin : -9px
</style>
