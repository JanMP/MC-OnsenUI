export roles =
  computed :
    currentUser : -> @$store.state.auth.user
    isTeacher : -> Roles.userIsInRole @currentUser?._id, "mentor"
    isAdmin : -> Roles.userIsInRole @currentUser?._id, "admin"
