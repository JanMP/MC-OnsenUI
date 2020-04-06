import React, {useState} from 'react'
import 'onsenui/css/onsenui.css'
import 'onsenui/css/onsen-css-components.css'

import {Button, Page, Splitter, SplitterSide, SplitterContent} from 'react-onsenui'
import ProblemNavigator from './ProblemNavigator'

export default App = ->
  
  <Splitter>
    <SplitterContent>
      <ProblemNavigator/>
    </SplitterContent>
    <SplitterSide
      side="right"
      width={200}
      swipeable={true}
      collapse="portrait"
    >
      <Page>Das wird mal ein Menü</Page>
    </SplitterSide>
  </Splitter>

