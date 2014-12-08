class @AdminRouteController extends RouteController
  onBeforeAction: ()->
#    if Meteor.loggingIn()
#      @render 'loading'
#    else
    if !Meteor.user() or !Meteor.user().hasAccess 'admin'
      @render 'notFound'
    else
      @next()
