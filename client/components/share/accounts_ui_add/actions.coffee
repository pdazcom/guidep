Template._loginButtonsAdditionalLoggedInDropdownActions.helpers
  admin: ->
    Meteor.userId() && Meteor.user().hasAccess 'admin'

Template._loginButtonsAdditionalLoggedInDropdownActions.events
  'click #login-buttons-admin': ->
    Router.go 'admin'