import { Meteor } from "meteor/meteor"

#require "/imports/api/AccountsTemplates.coffee"
require "/imports/api/users.coffee"
require "/imports/api/schoolClasses.coffee"
require "/imports/api/submissions.coffee"
require "/imports/api/chatMessages.coffee"
require "/imports/api/activityGraphs.coffee"
require "/imports/api/publications.coffee"

runMobile = false

if Meteor.isCordova or (Meteor.isDevelopment and runMobile)
  require "/imports/client/mobileStartup.coffee"
else
  require "/imports/client/webStartup.coffee"