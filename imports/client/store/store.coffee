import authModule from "./auth.coffee"

strict = false

export default store =
  modules :
    auth : authModule
    navigator :
      strict : strict
      namespaced : true
      state :
        stack : []
        options : {}
        moduleKey : ""
      mutations :
        push : (state, page) -> state.stack.push page
        selectModule : (state, moduleKey) -> state.moduleKey = moduleKey
        unselectModule : (state) -> state.moduleKey = ""
        pop : (state) -> state.stack.pop() if state.stack.length > 1
        options : (state, newOptions = {}) -> state.options = newOptions
    menu :
      strict : strict
      namespaced : true
      state :
        showMenu : false
        selected : "news"
      mutations :
        toggle : (state, newValue) ->
          state.showMenu = newValue ? not state.showMenu
        select : (state, newValue) ->
          state.selected = newValue
    unsolvedProblems :
      strict : strict
      namespaced : true
      state :
        problem : {}
      mutations :
        add : (state, newValue) ->
          moduleKey = newValue.moduleKey
          level = newValue.level
          state.problem[moduleKey] ?= {}
          state.problem[moduleKey][level] = newValue
        remove : (state, newValue) ->
          moduleKey = newValue.moduleKey
          level = newValue.level
          delete state.problem[moduleKey][level]
