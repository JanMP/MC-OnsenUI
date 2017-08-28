import { Meteor } from 'meteor/meteor'
import { Vue } from 'meteor/akryum:vue'
import Vuex from 'vuex'
import storeDef from '/imports/client/store/store.coffee'
import VueMarkdown from "vue-markdown"

# import '/imports/client/ui/mobile/main.css'

import VueOnsen from 'vue-onsenui'
import AppSplitter from '/imports/client/ui/mobile/AppSplitter.vue'
import CustomToolbar from '/imports/client/ui/mobile/CustomToolbar.vue'


Meteor.startup ->
  $('head').append "<link rel='stylesheet' href='onsenui/css/onsenui.css'/>"
  $('head').append "<link rel='stylesheet' \
    href='onsenui/css/onsen-css-components.css'/>"
  $('head').append "<link rel='stylesheet' href='katex/katex.min.css'/>"
  Vue.use VueOnsen
  Vue.component "markdown", VueMarkdown
  Vue.component "custom-toolbar", CustomToolbar
  new Vue
    el : '#app'
    render : (h) -> h(AppSplitter)
    store : new Vuex.Store storeDef
    meteor :
      meteorUser : ->
        @$store.commit "updateUser", Meteor.user()
