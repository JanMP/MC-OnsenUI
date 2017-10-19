import { Meteor } from "meteor/meteor"

#require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"
require "/imports/api/activityGraphs.coffee"
require "/imports/api/publications.coffee"

import { Vue } from "meteor/akryum:vue"

import Vuex from "vuex"
import storeDef from "/imports/client/store/store.coffee"

import VuexI18n from "vuex-i18n"
import { translationsDe } from "/imports/client/ui/translationsDe.coffee"
import { translationsEn } from "/imports/client/ui/translationsEn.coffee"

import VueMarkdown from "vue-markdown"
import VueOnsen from "vue-onsenui"

import AppSplitter from "/imports/client/ui/AppSplitter.vue"
import CustomToolbar from "/imports/client/ui/CustomToolbar.vue"

Meteor.startup ->
  Vue.use VueOnsen

  store = new Vuex.Store storeDef
  Vue.use VuexI18n.plugin, store

  Vue.i18n.add "de", translationsDe
  Vue.i18n.add "en", translationsEn

  language = testLanguage ? window.navigator.language.slice 0, 2

  Vue.i18n.set language

  Vue.component "markdown", VueMarkdown
  Vue.component "custom-toolbar", CustomToolbar

  vm = new Vue
    el : '#app'
    render : (h) -> h(AppSplitter)
    store : store
    meteor :
      meteorUser : ->
        @$store.commit "updateUser", Meteor.user()

  vm.$store.commit "locale/setLanguage", language
