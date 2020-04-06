import React, {useState} from 'react'
import {Navigator} from 'react-onsenui'
import ProblemPage from './ProblemPage/ProblemPage'
import ModuleListPage from './ModuleListPage/ModuleListPage'

export default ProblemNavigator = ->
  
  setRouteFor = (navigator) -> (moduleKey) -> navigator.pushPage {moduleKey}
    


  renderPage = (route, navigator) ->
    if route.moduleKey?
      <ProblemPage moduleKey={route.moduleKey} onPop={navigator.popPage}/>
    else
      <ModuleListPage selectModule={setRouteFor navigator}/>

  initialRoute =
    moduleKey: null #"linGlSys"
    
  <Navigator
    renderPage={renderPage}
    initialRoute={initialRoute}
  />
