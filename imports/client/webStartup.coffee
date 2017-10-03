import { Meteor } from 'meteor/meteor'
import { Vue } from 'meteor/akryum:vue'
import Vuex from 'vuex'
import storeDef from '/imports/client/store/store.coffee'

# import 'element-ui/lib/theme-default/index.css'
import ElementUI from 'element-ui'
import locale from 'element-ui/lib/locale/lang/de'

import DataTables from 'vue-data-tables'

import Icon from 'vue-awesome'
import VueMarkdown from 'vue-markdown'

import AppLayout from '/imports/client/ui/web/AppLayout.vue'

import { RouterFactory, nativeScrollBehavior } from 'meteor/akryum:vue-router2'
import routes from '/imports/client/ui/web/routes.coffee'
routerFactory = new RouterFactory
  mode : "history"
  scrollBehavior : nativeScrollBehavior

RouterFactory.configure (router) ->
  router.addRoutes routes

Meteor.startup ->
  $('head').append "<link rel='stylesheet' href='https://unpkg.com/element-ui/lib/theme-default/index.css'>"
  $('head').append "<link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/KaTeX/0.7.1/katex.min.css'/>"
  Vue.use ElementUI, { locale }
  Vue.use DataTables
  Vue.component "markdown", VueMarkdown
  Vue.component "icon", Icon
  new Vue
    el : '#app'
    store : new Vuex.Store storeDef
    router : routerFactory.create()
    render : (h) -> h AppLayout
    meteor :
      meteorUser : ->
        @$store.commit "updateUser", Meteor.user()
