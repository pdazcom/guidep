Meteor.startup ->
  if Meteor.isClient
    Meteor.subscribe "profile"