class @AdminRouteController extends RouteController
  onBeforeAction: ->
    console.info "onBeforeAction: #{@url}"
#    if Meteor.loggingIn()
#      @render 'loading'
#    else if !Meteor.userId() or !Meteor.user().hasAccess 'admin'
#      @render 'notFound'
#    else
    @next()

  onAfterAction: ->
    console.info "onAfterAction: #{@url}"

  onRun: ->
    console.info "onRun: #{@url}"
    if Meteor.loggingIn()
      @render 'loading'
    else if !Meteor.userId() or !Meteor.user().hasAccess 'admin'
      @render 'notFound'
    else
      @next()

  onRerun: ->
    console.info "onRerun: #{@url}"
    if Meteor.loggingIn()
      @render 'loading'
    else if !Meteor.userId() or !Meteor.user().hasAccess 'admin'
      @render 'notFound'
    else
      @next()

  onStop: ->
    console.info "onStop: #{@url}"