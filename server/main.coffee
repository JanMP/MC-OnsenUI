import { Meteor } from 'meteor/meteor'
#import "/imports/api/AccountsTemplates.coffee"

# import "/imports/api/users.coffee"
# import "/imports/api/schoolClasses.coffee"
# import "/imports/api/submissions.coffee"
# import "/imports/api/chatMessages.coffee"
# import "/imports/api/activityGraphs.coffee"
# import "/imports/api/publications.coffee"

Meteor.startup ->
  admin = Meteor.users.findOne username : "admin"
  if admin?
    Roles.addUsersToRoles admin._id, [
      "admin", "superAdmin"
    ]