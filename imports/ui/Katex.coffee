import React, {useState, useEffect} from 'react'
import katex from "katex"


export default Katex = ({tex, options}) ->
  
  options ?=
    displayMode : true
    throwOnError : false

  html = if typeof tex is "string" then katex.renderToString tex, options else ""


  <div dangerouslySetInnerHTML={__html: html} />
