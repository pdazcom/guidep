class @AdminRouteController extends RouteController
  onBeforeAction: ->
    console.log "onBeforeAction: #{this.url}"
    if Meteor.loggingIn()
      @render 'loading'
    else if !Meteor.userId() or !Meteor.user().hasAccess 'admin'
      @render 'notFound'
    else
      @next()
