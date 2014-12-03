Handlebars.registerHelper "isAdmin", ()->
  if !Meteor.userId() or !Meteor.user()
    return false
  else
    return !!Meteor.user() && Meteor.user().hasAccess 'admin'
