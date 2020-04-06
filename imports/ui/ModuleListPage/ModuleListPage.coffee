import React, {useState, useEffect} from 'react'
import {Page} from 'react-onsenui'
import ModuleList from './ModuleList'
import {getModulesList} from '/imports/mathProblems/getModulesList'

moduleList = getModulesList "de"

export default ModuleListPage = ({selectModule}) ->

  <Page>
    <ModuleList list={moduleList[0]} selectModule={selectModule}/>
  </Page>