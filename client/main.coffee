import { Meteor } from 'meteor/meteor'

import { Vue } from 'meteor/akryum:vue'
import Vuex from 'vuex'
import VueOnsen from 'vue-onsenui'
import storeDef from '/imports/client/store.coffee'

import AppSplitter from '/imports/client/ui/AppSplitter.vue'
import CustomToolbar from '/imports/client/ui/CustomToolbar.vue'

Meteor.startup ->
  Vue.use VueOnsen
  Vue.component "custom-toolbar", CustomToolbar
  new Vue
    el : '#app'
    render : (h) -> h(AppSplitter)
    store : new Vuex.Store storeDef
