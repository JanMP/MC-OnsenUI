import { Meteor } from 'meteor/meteor'

#require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"
require "/imports/api/activityGraphs.coffee"
require "/imports/api/publications.coffee"

import { Vue } from 'meteor/akryum:vue'
import Vuex from 'vuex'
import VueOnsen from 'vue-onsenui'
import VueMarkdown from "vue-markdown"
import storeDef from '/imports/client/store.coffee'

import AppSplitter from '/imports/client/ui/AppSplitter.vue'
import CustomToolbar from '/imports/client/ui/CustomToolbar.vue'

Meteor.startup ->
  Vue.use VueOnsen
  Vue.use VueMarkdown
  Vue.component "custom-toolbar", CustomToolbar
  new Vue
    el : '#app'
    render : (h) -> h(AppSplitter)
    store : new Vuex.Store storeDef
