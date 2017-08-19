export default {
  modules :
    navigator :
      strict : true
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
      strict : true
      namespaced : true
      state :
        showMenu : false
      mutations :
        toggle : (state, newValue) ->
          state.showMenu = newValue ? not state.showMenu
}
