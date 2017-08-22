import { Meteor } from "meteor/meteor"
import { Accounts } from "meteor/accounts-base"

export default authModule =
  state :
    user : null
  mutations :
    updateUser : (state, value) ->
      state.user = value
  actions :
    createUser : ( {commit, state }, options ) ->
      Accounts.createUser options, (error) ->
        console.log if error?
          error.reason
        else
          "#{options.username} signed-up"
    loginUser : ( {commit, state }, options ) ->
      Meteor.loginWithPassword options.username, options.password, (error) ->
        console.log if error?
          error.reason
        else
          "#{options.username} signed-in"
    logoutUser : -> Meteor.logout -> console.log "user signed-out"
