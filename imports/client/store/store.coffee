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
        init : (state, page) ->
          if state.stack.length is 0 then state.stack.push page
        push : (state, page) -> state.stack.push page
        selectModule : (state, moduleKey) -> state.moduleKey = moduleKey
        unselectModule : (state) -> state.moduleKey = ""
        pop : (state) -> state.stack.pop() if state.stack.length > 1
        options : (state, newOptions = {}) -> state.options = newOptions
    locale :
      strict : strict
      namespaced : true
      state :
        language : "en"
      mutations :
        setLanguage : (state, language) -> state.language = language
    adminPanelUserNavigator :
      strict : strict
      namespaced : true
      state :
        stack : []
        options : {}
        userId : ""
      mutations :
        init : (state, page) ->
          if state.stack.length is 0 then state.stack.push page
        push : (state, page) -> state.stack.push page
        selectUser : (state, userId) -> state.userId = userId
        unselectUser : (state) -> state.userId = ""
        pop : (state) -> state.stack.pop() if state.stack.length > 1
        options : (state, newOptions = {}) -> state.options = newOptions
    adminPanelSchoolClassNavigator :
      strict : strict
      namespaced : true
      state :
        stack : []
        options : {}
        schoolClassId : ""
      mutations :
        init : (state, page) ->
          if state.stack.length is 0 then state.stack.push page
        push : (state, page) -> state.stack.push page
        selectSchoolClass : (state, id) -> state.schoolClassId = id
        unselectSchoolClass : (state) -> state.schoolClassId = ""
        pop : (state) -> state.stack.pop() if state.stack.length > 1
        options : (state, newOptions = {}) -> state.options = newOptions
    teacherPanelNavigator :
      strict : strict
      namespaced : true
      state :
        stack : []
        options : {}
        schoolClassId : ""
        studentId : ""
      mutations :
        init : (state, page) ->
          if state.stack.length is 0 then state.stack.push page
        push : (state, page) -> state.stack.push page
        selectSchoolClass : (state, id) -> state.schoolClassId = id
        unselectSchoolClass : (state) -> state.schoolClassId = ""
        selectStudent : (state, id) -> state.studentId = id
        unselectStudent : (state) -> state.studentId = ""
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
