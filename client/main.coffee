import React from 'react'
import {render} from 'react-dom'
import {Meteor} from 'meteor/meteor'
import {Mongo} from 'meteor/mongo'

import "./main.styl"
import App from '/imports/ui/App'

#require "/imports/api/AccountsTemplates.coffee"
# import "/imports/api/users.coffee"
# import "/imports/api/schoolClasses.coffee"
# import "/imports/api/submissions.coffee"
# import "/imports/api/chatMessages.coffee"
# import "/imports/api/activityGraphs.coffee"
# import "/imports/api/publications.coffee"

# import { Vue } from "meteor/akryum:vue"

# import Vuex from "vuex"
# import storeDef from "/imports/client/store/store.coffee"

# import VuexI18n from "vuex-i18n"
# import { translationsDe } from "/imports/client/ui/translationsDe.coffee"
# import { translationsEn } from "/imports/client/ui/translationsEn.coffee"

# import VueMarkdown from "vue-markdown"
# import VueOnsen from "vue-onsenui"

# import AppSplitter from "/imports/client/ui/AppSplitter.vue"
# import CustomToolbar from "/imports/client/ui/CustomToolbar.vue"

Meteor.startup ->
  language = testLanguage ? window.navigator.language.slice 0, 2
  console.log language
  # moment.locale 'de'
  render <App />, document.getElementById 'react-target'
  
  # Vue.use VueOnsen

  # store = new Vuex.Store storeDef
  # Vue.use VuexI18n.plugin, store

  # Vue.i18n.add "de", translationsDe
  # Vue.i18n.add "en", translationsEn


  # Vue.i18n.set language

  # Vue.component "markdown", VueMarkdown
  # Vue.component "custom-toolbar", CustomToolbar

  # vm = new Vue
  #   el : '#app'
  #   render : (h) -> h(AppSplitter)
  #   store : store
  #   meteor :
  #     meteorUser : ->
  #       @$store.commit "updateUser", Meteor.user()

  # vm.$store.commit "locale/setLanguage", language
