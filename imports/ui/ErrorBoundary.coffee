import {Meteor} from 'meteor/meteor'
import React from 'react'
import _ from 'lodash'

# Error Boundary with callback onError
export default class ErrorBoundary extends React.Component
  constructor: (props) ->
    super props
    @onError = props.onError ? -> console.log 'fnord'
    @state =
      hasError: false

  # shouldComponentUpdate: (nextProps, nextState) ->
  #   console.log 'shouldComponentUpdate: hasError: ', @state.hasError
  #   unless _.isEqual nextProps.data, @props.data
  #     console.log 'props.data changed'
  #     if @state.hasError
  #       @setState hasError: false
  #     return true
  #   unless @state.hasError is nextState.hasError
  #     return true
  #   false


  componentDidCatch: (error, info) ->
    @setState hasError: true
    console.error 'Caught by ErrorBoundary:', error, info
    @onError()

  render: ->
    if @state.hasError
      <div>
        <h1>☠️</h1>
      </div>
    else
      @props.children
