<template lang="jade">
.site
  .header
    h1 MatheCoach
  .site-content()
    el-menu.menu-view(v-bind:router="true" v-bind:default-active="active")
      el-menu-item(index="/login")
        icon.front(name="sign-in" scale="1.3")
        |Sign-In
      el-menu-item(index="/")
        icon.front(name="info-circle" scale="1.3")
        |News
      el-menu-item(index="/aufgaben")
        icon.front(name="list" scale="1.3")
        |Aufgaben
      el-menu-item(index="/statistik")
        icon.front(name="bar-chart" scale="1.3")
        |Meine Statistik
    router-view.main-view
  .footer
    .message MatheCoach © 2016 Jan Pilgenröder

</template>

<script lang="coffee">
return
  data : ->
    active : ""
  mounted : ->
    if @$route.path in ["/login", "/", "/aufgaben", "/statistik"]
      @active = @$route.path
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
  height : 45px
  line-height : 45px
.main-view
  flex : 1
  padding : 5px
.header
  background-color : #20A0FF
  padding : 15px
  color : white
.footer
  background-color : #20A0FF
  padding : .5em
  text-align : center
  .message
    color : white
    font-size : .8em
.text-container
  max-width : 600px
  padding : 20px
h1, h2, h3, h4, h5, h6
  margin : 0
  padding : 0
p
  margin : .4em 0 .2em 0
</style>
