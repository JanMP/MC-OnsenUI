import React, {useState, useEffect} from 'react'
import {List, ListHeader, ListItem} from 'react-onsenui'

export default ModuleList = ({list, selectModule}) ->

  selectModule ?= (moduleKey) -> console.log "should select Module #{moduleKey}"

  hasChildren = (obj) -> obj?.kindred?.length > 0

  handleClick = (row) -> ->
    if (moduleKey = row?.moduleKey)?
      selectModule moduleKey

  renderHeader = ->
    if hasChildren list
      <ListHeader>{list.title}</ListHeader>
    else null

  renderRow = (row, index) ->
    if hasChildren row
      <ModuleList list={row} selectModule={selectModule} key={index}/>
    else
      <ListItem onClick={handleClick row} key={index}>
        <span className="list-item__title">{row.title}</span>
        <span className="list-item__subtitle">{row.description}</span>
      </ListItem>
  
  <List
    dataSource={list.kindred}
    renderHeader={renderHeader}
    renderRow={renderRow}
  />