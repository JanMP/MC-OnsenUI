<template lang="jade">
.site
  .header
    .title MatheCoach
  .site-content()
    el-menu.menu-view(v-bind:router="true" default-active="/")
      el-menu-item(index="/login")
        icon.front(name="sign-in" scale="1.3")
        |Sign-In
      el-menu-item(index="/")
        icon.front(name="info-circle" scale="1.3")
        |News
      el-menu-item(index="/aufgaben")
        icon.front(name="list" scale="1.3")
        |Aufgaben
    router-view.main-view
  .footer
    .message MatheCoach © 2016 Jan Pilgenröder

</template>

<script lang="coffee">
</script>

<style lang="sass">
body
  font-family: "Helvetica Neue",Helvetica,"PingFang SC","Hiragino Sans GB","Microsoft YaHei","微软雅黑",Arial,sans-serif
  margin : 0px
.front
  width : 1em
  margin-right : 10px
.site
  margin : 0
  padding : 0
  display : flex
  min-height : 100vh
  flex-direction : column
  box-sizing : border
.site-content
  flex : 1
  display : flex
  flex-direction : row
.menu-view
  flex : 0 160px
.el-menu-item
  font-size : 1.1em
.main-view
  flex : 1
  padding : 10px
.header
  background-color : #475669
  padding : .5em
  .title
    color : white
    font-size : 1.5em
.footer
  background-color : #475669
  padding : .5em
  text-align : center
  .message
    color : white
    font-size : .8em
</style>
